--[[
    You can test this locally by removing line 8:
    if (GetLocale() ~= "frFR") then return; end

    These translations where provided by
        - Bhahlou
]]
if (GetLocale() ~= "frFR") then return; end
local L = Gargul_L or {};

L["About"] = "À propos";
L["All Settings"] = "Tous les paramètres";
L["Announce"] = "Annoncer";
L["Anti Snipe"] = "Anti-snipe";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Une valeur anti-snipe de 10 signifie que toute enchère reçue avec
moins de 10 secondes restantes réinitialiseront la minuterie à 10 secondes.

Vous pouvez laisser ce champ vide ou le définir sur 0 pour désactiver complètement l'Anti-snipe.
Les valeurs anti-snipe inférieures à 5 ne sont pas prises en charge.

]];
L["Are you sure?"] = "Es-tu sûr ?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
N'oubliez pas d'utiliser Gargul à la place
si vous souhaitez exporter le butin plus tard


-- Faites un clic droit pour désactiver cette fenêtre --]];
L["Auction"] = "Enchères";
L["Auctioneer"] = "Commissaire-priseur";
L["Auctions"] = "Enchères";
L["Auto"] = "Auto";
L["Auto Roll"] = "Lancer auto";
L["Enable Auto Roll"] = "Activer le lancer auto";
L["Auto roll is active ( profile: %s )"] = "Lancer auto actif ( profil: %s )";
L["now supports auto rolling: |c00%s/gl ar|r or |c00%s/gl autoroll|r"] = "Gargul prend maintenant en charge le lancer auto : |c00%s/gl ar|r ou |c00%s/gl autoroll|r";
L["You automatically passed on %s"] = "Vous avez automatiquement passé sur %s";
L["You automatically needed on %s"] = "Vous avez automatiquement need sur %s";
L["You automatically greeded on %s"] = "Vous avez automatiquement greed sur %s";
L["Action"] = "Action";
L["Add"] = "Ajouter";
L["Add item rules to automatically roll need, greed or pass when a roll is announced. Rules are stored per item ID. When you win an item, its rule is automatically set to pass."] = "Ajoutez des règles pour lancer automatiquement need, greed ou pass. Les règles sont stockées par ID d'objet. Lorsque vous gagnez un objet, sa règle passe automatiquement à pass.";
L["Add item rules to automatically roll need, greed or pass when a Gargul roll is announced (does not work with group loot rolls). Rules are stored per item ID. When you win an item, its rule is automatically set to pass. Shift-click items, drag them into the box below or just start typing to search."] = "Ajoutez des règles pour lancer automatiquement need, greed ou pass lorsqu'un lancer Gargul est annoncé (ne fonctionne pas avec les lancers de butin de groupe). Les règles sont stockées par ID. Lorsque vous gagnez un objet, sa règle passe à pass. Maj+clic sur les objets ou glissez-les dans la case ci-dessous.";
L["Add rule"] = "Ajouter une règle";
L["4. Automatically roll need, greed or pass based on saved rules! Click below or use |c00A79EFF/gl ar"] = "4. Lancez automatiquement need, greed ou pass selon vos règles ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl ar";
L["Automatically roll need, greed or pass based on your saved rules when a Gargul roll is announced. Does not work with group loot rolls. Manage rules via the Auto Roll Rules section or |c00A79EFF/gl autoroll|r"] = "Lancez automatiquement need, greed ou pass selon vos règles lorsqu'un lancer Gargul est annoncé. Ne fonctionne pas avec les lancers de butin de groupe. Gérez les règles via Auto Roll Rules ou |c00A79EFF/gl autoroll|r";
L["No rules yet. Add an item link and choose need, greed or pass."] = "Aucune règle. Ajoutez un lien d'objet et choisissez need, greed ou pass.";
L["Your rules"] = "Vos règles";
L["Clear all"] = "Tout effacer";
L["Remove all rules from this profile"] = "Supprimer toutes les règles de ce profil";
L["Remove all rules from this profile?"] = "Supprimer toutes les règles de ce profil ?";
L["Item link, ID, or type to search"] = "Lien ou ID d'objet";
L["Manage Auto Roll Rules"] = "Gérer les règles de lancer auto";
L["Invalid item link or ID"] = "Lien ou ID d'objet non valide";
L["(copy)"] = "(copie)";
L["A profile with that name already exists."] = "Un profil avec ce nom existe déjà.";
L["Copy profile"] = "Copier le profil";
L["Create profile"] = "Créer un profil";
L["Delete profile"] = "Supprimer le profil";
L["Delete profile \"%s\"?"] = "Supprimer le profil \"%s\" ?";
L["No profile"] = "Aucun profil";
L["Profile name"] = "Nom du profil";
L["Profile: "] = "Profil : ";
L["Rename profile"] = "Renommer le profil";
L["Auto award"] = "Attribution auto"
L["Auto trade"] = "Options échange auto";
L["Available values:"] = "Valeurs disponibles :";
L["Award"] = "Attribuer";
L["Awarded To"] = "Attribué à";
L["BR: %s"] = "LB : %s";
L["Price: %s"] = "Prix : %s";
L["Given: yes"] = "Donné : oui";
L["Given: no"] = "Donné : non";
L["2nd bid: %s by %s"] = "2ème enchère : %s par %s";
L["You won"] = "Vous avez gagné";
L["Award %s to %s?"] = "Attribuer %s à %s ?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "Etes-vous sûr de vouloir désenchanter %s ? %s points de lancer boosté seront remboursés !";
L["In Group"] = "En groupe";
L["Award history"] = "Historique des attributions";
L["Who should %s go to instead?"] = "À qui %s devrait-il s'adresser à la place ?";
L["Type player name here"] = "Tapez le nom du joueur ici";
L["or select one below"] = "ou sélectionnez-en un ci-dessous";
L["Do you want to award %s to a random player?"] = "Voulez-vous attribuer %s à un joueur aléatoire ?";
L["Drag and drop or shift+click an item in the box on the right"] = "Glisser-déposer ou Maj+clic sur un élément dans la case de droite";
L["(BR: %s)"] = "(LB : %s)";
L["Disenchanted items:"] = "Objets désenchantés :";
L["(Given: yes)"] = "(Donné : oui)";
L["(Given: no)"] = "(Donné : non)";
L["(OS)"] = "(+2)";
L["%s boosted roll points will be refunded!"] = "%s points de lancer boosté seront remboursés !";
L["Are you sure you want to undo %s awarded to %s?%s"] = "Etes-vous sûr de vouloir annuler %s attribué à %s ?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "Échec de l'inspection des sacs : aucun rapport reçu";
L["Inspection finished"] = "Inspection terminée";
L["Starting inspection..."] = "Début de l'inspection...";
L["Balance"] = "Différence";
L["Base"] = "Base";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Impossible de décoder les données en base64. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
L["Bid"] = "Enchère";
L["Bids"] = "Enchères";
L["BOE"] = "LQE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. Inviter/trier automatiquement les groupes à partir de l'inscription au raid ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. Récompensez les joueurs qui sont des habitués ou qui font un effort supplémentaire ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul a quelques tours dans son sac que vous ne connaissez peut-être pas. Jetez un œil !";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul comprend un système de suivi des +1 ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl po";
L["Boosted Rolls"] = "Lancers de dés améliorés";
L["BR"] = "LA";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
Ajoutez combien de points pour tous ceux qui participent actuellement au raid ?

|c00BE3333Utilisez d'abord le bouton « Ajouter des raideurs manquants » si vous souhaitez que tout le monde obtienne des points, même ceux qui n'ont pas d'entrée améliorée !]];
L["No point value provided!"] = "Aucune valeur en points fournie !";
L["Add points to raid"] = "Ajouter des points au raid";
L["Add missing raiders"] = "Ajouter les raiders manquants";
L["Aliases"] = "Alias";
L["Apply aliases"] = "Appliquer des alias";
L["Boosted Roll Cost:"] = "Coût du lancer amélioré :";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "Êtes-vous sûr de vouloir diffuser vos données de lancers améliorés à tous les membres de votre groupe/raid ?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "Rien à diffuser, importez d'abord les données de lancers améliorés !";
L["Couldn't process BoostedRolls data received from %s"] = "Impossible de traiter les données de lancers améliorés reçues de %s";
L["Attempting to process incoming BoostedRolls data from %s"] = "Tentative de traitement des données de lancers améliorés entrantes provenant de %s";
L["Are you sure you want to clear all boosted roll data?"] = "Etes-vous sûr de vouloir effacer toutes les données de lancers améliorés ?";
L["Delete %s?"] = "Supprimer %s ?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "Etes-vous sûr de vouloir effacer vos données de lancers améliorés existantes et importer de nouvelles données diffusées par %s ?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Données non valides fournies. Assurez-vous que le contenu suit le format requis et qu'aucune ligne d'en-tête n'est incluse.";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
Ici, vous pouvez importer des données de lancers améliorés et des alias à partir d'un tableau au format CSV ou TSV ou collés à partir d'une feuille Google Docs.

Le tableau nécessite au moins deux colonnes : Le nom du joueur suivi du nombre de points. Les colonnes supplémentaires sont facultatives et peuvent contenir des alias pour le joueur.
Voici un exemple de ligne :

Foobar,240,Barfoo]];
L["Points"] = "Points";
L["Points: %s"] = "Points : %s";
L["N/A"] = "N/D";
L["Reserve"] = "Réserve";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Etes-vous sûr de vouloir mettre à jour vos lancers améliorés existants avec les données de %s ?

Votre dernière mise à jour était sur |c00A79EFF%s, la leur sur |c00A79EFF%s.]];
L["!bonus|!rb|!br"] = "!bonus|!br|!la";
L["Broadcast"] = "Diffuser";
L["Broadcasting..."] = "Diffusion...";
L["You are currently in combat, delaying broadcast"] = "Vous êtes actuellement en combat, la diffusion est reportée";
L["Broadcast finished!"] = "Diffusion terminée !";
L["Include awarded items"] = "Inclure les objets attribués";
L["Include disenchanted items"] = "Inclure les objets désenchantés";
L["Include hidden items"] = "Inclure les éléments masqués";
L["Include time left"] = "Inclure le temps restant";
L["Broadcast still in progress"] = "Diffusion toujours en cours";
L["There is nothing to broadcast"] = "Il n'y a rien à diffuser";
L["Number of items"] = "Nombre d'objets";
L["Broadcast ${percentage}%"] = "Diffusion ${percentage} %";
L["Target player (whisper only)"] = "Joueur ciblé (chuchotement uniquement)";
L["Whisper requires a target player"] = "Chuchoter nécessite un joueur ciblé";
L["Max trade time left (in minutes)"] = "Temps de transaction maximum restant (en minutes)";
L["by"] = "par"; -- As in 'bid BY'
L["Cancel"] = "Annuler";
L["Get support or share ideas on our Discord"] = "Obtenez de l'aide ou partagez des idées sur notre Discord";
L["Enable changelog"] = "Activer le journal des modifications";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul rend la distribution du butin très simple, cliquez sur le bouton ci-dessous pour commencer !";
L["Open Gargul"] = "Ouvrir Gargul";
L["Adjust Scale"] = "Ajuster l'échelle";
L["Channel"] = "Canal";
L["Officer"] = "Officier";
L["Raid Warning"] = "Avertissement de raid";
L["Whisper"] = "Chuchoter";
L["CPR"] = "RCR";
L["Clear"] = "Effacer"; -- As in clearing a window or data
L["Close"] = "Fermer";
L["Close on award"] = "Fermer à l'attribution";
L["Close on start"] = "Fermer au démarrage";
L["Communication"] = "Communication";
L["Sent %s of %s bytes"] = "Envoyé %s sur %s octets";
L["c"] = "pc";
L["Cut"] = "Part";
L["Cuts"] = "Parts";
L["Can't send mail when the mailbox is closed"] = "Impossible d'envoyer du courrier lorsque la boîte aux lettres est fermée";
L["Multiple mail errors detected, aborting cut distribution"] = "Plusieurs erreurs de courrier détectées, abandonnant la distribution des parts";
L["You don't owe %s any gold"] = "Vous ne devez pas d'or à %s";
L["Failed to send cut to %s"] = "Échec de l'envoi de la part à %s";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "Mail ENVOYÉ selon le jeu, mais votre OR restant NE CORRESPOND PAS, quelque chose s'est mal passé ?";
L["Mail History for |c00967FD2%s"] = "Historique du courrier pour |c00967FD2%s";
L["You don't have enough gold to pay %s"] = "Vous n'avez pas assez d'or pour payer %s";
L["Wait a bit, we're still processing the previous mail"] = "Attendez un peu, nous sommes toujours en train de traiter le mail précédent";
L["Gargul GDKP: %sg"] = "Gargul GDKP : %sg";
L["Sent %sg to %s"] = "Envoyé %sg à %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "Supprimer";
L["Details"] = "Détails";
L["DFT"] = "DFT";
L["Disable"] = "Désactiver";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "Désenchanter";
L["Edit"] = "Modifier";
L["Enable"] = "Activer";
L["Export"] = "Exporter";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "Êtes-vous sûr de vouloir supprimer l'intégralité de votre tableau d'historique des attributions ? Cela supprime TOUTES les données de butin et ne peut pas être annulé !";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "Êtes-vous sûr de vouloir supprimer toutes les données de %s ? Ça ne peut pas être annulé!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
Il s'agit UNIQUEMENT d'une fonctionnalité d'exportation, il ne sert à rien de modifier les valeurs : ELLES NE SERONT PAS SAUVEGARDÉES !

]];
L["Fill"] = "Remplir";
L["Final Call"] = "Dernier appel";
L["Finish"] = "Terminer";
L["Format"] = "Format";
L["Gargul"] = "Gargul";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "Les raids GDKP ne sont pas autorisés dans cette version de World of Warcraft";
L["GDKP Active!"] = "GDKP Actif !";
L["Add dropped loot to queue"] = "Ajouter le butin tombé à la file d'attente";
L["Gold (- for removing gold)"] = "Or (- pour retirer de l'or)";
L["Who pays for this?"] = "Qui paie pour ça ?";
L["Gold needs to be lower/higher than 0"] = "L'or doit être inférieur/supérieur à 0";
L["Paid for by"] = "Payé par";
L["Adjust gold in %s"] = "Ajuster l'or en %s";
L["You can't give AND receive gold from the same player at the same time"] = "Vous ne pouvez pas donner ET recevoir de l'or du même joueur en même temps";
L["All cuts were mailed!"] = "Toutes les parts ont été postées !";
L["Disable for disenchanted"] = "Désactiver pour les désenchantés";
L["Disable in combat"] = "Désactiver en combat";
L["Auctions"] = "Enchères";
L["Created by"] = "Créé par";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Supprimé par %s
Motif]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%spo ajouté au pot par %s
Remarques]];
L["Won by"] = "Gagné par";
L["Set paid amount (read left)"] = "Définir montant payé (lire à gauche)";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul garde automatiquement une trace de l'or échangé. Tant que les joueurs paient
pour ce qu'ils ont acheté, vous ne devriez jamais avoir besoin de ce champ

Le « montant payé » fait référence au montant d'or que l'acheteur vous a déjà échangé.
Cela ne change pas le prix réel de l'objet !

Attention : ne définissez ici une valeur que si le joueur promet de payer
en dehors du raid ou échange l'or depuis un reroll/mail etc !


]];
L["GDKP Price:"] = "Prix ​​​​GDKP :";
L["Award %s to %s for %s?"] = "Attribuer %s à %s pour %s ?";
L["Auto Bid"] = "Enchère auto";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "Quelle est votre enchère maximale ? (%s minimum|c00FFF569g)";
L["Bid denied!"] = "Enchère refusée !";
L["Min bid: %sg   Increment: %sg"] = "Enchère minimale : %spo Incrément : %spo";
L["(max %sg)"] = "(%spo maximum)";
L["New bid"] = "Nouvelle enchère";
L["Stop Auto Bid"] = "Arrêter enchère auto";
L["Top bid: %s by %s"] = "Enchère la plus élevée : %s par %s";
L["Top bid: %s by you"] = "Meilleure enchère : %s de votre part";
L["Create a new GDKP session"] = "Créer une nouvelle session GDKP";
L["Management Cut %"] = "% de part d'organisation";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "La part d'organisation doit être vide ou comprise entre 0 et 99 (pas de signe % !)";
L["Choose a session type!"] = "Choisissez un type de session !";
L["Switch to this session"] = "Passer à cette session";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFFMulti-enchères vous permet de lancer des enchères sur plusieurs objets à la fois, accélérant ainsi les choses !
Suivez les instructions après avoir créé cette session pour commencer

Avec |c00A79EFFEnchère unique, vous choisissez plutôt de mettre aux enchères des objets uniques ou d'utiliser la file d'attente

La sélection de |c00A79EFFMulti-enchères empêche l'ajout des objets tombés à la file d'attente.
Vous pouvez mélanger |c00A79EFFMulti-enchères avec |c00A79EFFEnchère unique et la file d'attente mais nous vous le déconseillons fortement.

]];
L["Auction type (|c00A79EFFi for more info)"] = "Type d'enchère (|c00A79EFFi pour plus d'infos)";
L["Multi-Auction"] = "Multi-enchères";
L["Single-Auction"] = "Enchère unique";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "Session créée. Nous vous conseillons de /reload pour qu'elle soit correctement stockée au cas où votre jeu planterait !";
L["Add Raider"] = "Ajouter raideur";
L["adjust [g]"] = "ajuster [po]";
L["adjust [%]"] = "ajuster [%]";
L["Announce the base cut in group chat"] = "Annoncer la part de base dans la discussion de groupe";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "Etes-vous sûr de vouloir réinitialiser tous les joueurs et calculs ? Attention : tous les joueurs qui ne sont plus dans le raid seront supprimés de la liste !";
L["Delete Raider"] = "Supprimer le raideur";
L["Edit Raider"] = "Modifier le raideur";
L["Lock and Pay"] = "Verrouiller & payer";
L["Manage gold trades"] = "Gérer les échanges d'or";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

Avec les mutateurs, vous pouvez donner plus ou moins d'or aux joueurs
Exemple : donner 2 % de plus aux tanks, c'est à cela que servent les mutateurs !

Remarque : La modification ou la suppression de mutateurs ici ne les modifie que pour cette session.

]];
L["Not in the raid"] = "Pas dans le raid";
L["\n\nThe total payout can differ slightly from the pot due to rounding differences!\nPlayers currently in the raid can not be edited or removed!\n\nColor explanation:\n|c00F7922E(2000g) Means you owe this person 2000g\n|c00BE3333(3000g) Means this person owes you 3000g\n|c0092FF00(0) Means that you're square\n\nAdjuster explanation:\nWith adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)\nWith adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)\n"] = [[

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
L["%s Raiders | %s With cut | Total payout: %s"] = "%s Raideurs | %s Avec part | Paiement total : %spo";
L["Nothing to import, double check your CSV"] = "Rien à importer, vérifiez votre CSV";
L["Missing gold for player %s"] = "Or manquant pour le joueur %s";
L["Missing header, note: it's case-sensitive!"] = "En-tête manquant, attention : il est sensible à la casse !";
L["Missing player name"] = "Nom du joueur manquant";
L["Delete bid. Auction must be stopped first!"] = "Supprimer l'enchère. Les enchères doivent d'abord être arrêtées !";
L["Add a raider to this session"] = "Ajouter un raideur à cette session";
L["Custom (create your own format)"] = "Personnalisé (créez votre propre format)";
L["Detailed (JSON)"] = "Détaillé (JSON)";
L["Share (can be imported by other players)"] = "Partager (peut être importé par d'autres joueurs)";
L["Your custom format"] = "Votre format personnalisé";
L["Your custom header"] = "Votre en-tête personnalisé";
L["Custom (create your own format)"] = "Personnalisé (créez votre propre format)";
L["@PLAYER,@CUT"] = "@PLAYER,@CUT";
L["Player,Cut"] = "Joueur, Part";
L["date/time at which the session was locked"] = "date/heure à laquelle la session a été verrouillée";
L["total gold given to the player"] = "or total donné au joueur";
L["gold mailed to the player"] = "or envoyé au joueur";
L["total gold received from the player"] = "or total reçu du joueur";
L["date/time at which the first item was awarded"] = "date/heure à laquelle le premier objet a été attribué";
L["gold traded to the player"] = "or échangé au joueur";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "Objet, Joueur, Or, Wowheadlink";
L["Date/time at which the first item was awarded"] = "Date/heure à laquelle le premier objet a été attribué";
L["The title of the GDKP session"] = "Titre de la session du GDKP";
L["Include disenchanted items"] = "Inclure les objets désenchantés";
L["Pot changed"] = "Pot changé";
L["Gold Trades"] = "Métiers de l'or";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "Êtes-vous sûr? Vous ne pourrez ni voir ni enchérir sur les objets à venir !";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! ATTENTION !!|r

Vous êtes sur un royaume connecté et importez des noms de joueurs sans
un suffixe de domaine, '%s' par exemple. Cela peut vous amener à envoyer
des parts et poster des parts au mauvais joueur.

Lorsque vous êtes sur un royaume connecté, essayez toujours d'inclure le nom du royaume des joueurs !

Continuer l'importation ?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "Cela annulera toutes les modifications que vous avez apportées à la fenêtre de parts, en êtes-vous sûr ?";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Vous pouvez importer les parts de joueurs à partir de vos propres calculs comme une feuille Google. softres GDKP etc.

Le format est le suivant (|c00BE3333INCLUDE THE HEADER !!) :

|c00BE3333Player,Gold|c00967FD2
Joueur1,4000
Joueur2,4125
Joueur3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
Importez les prix minimum et les incréments du GDKP.

Le format est le suivant : ItemID + minimum ou incrément sont requis. (|c00BE3333NÉCESSITE UN EN-TÊTE !!) :

|c00BE3333ItemID,Minimum,Increment|c00967FD2
18608,4000,500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "Supprimer les paramètres de prix existants ? Cliquez sur oui pour supprimer toutes les données de prix, sur non pour simplement remplacer celles existantes par les données que vous avez fournies ici.";
L["Import GDKP Session"] = "Importer une session GDKP";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "Ici, vous pouvez importer (et continuer) une session GDKP. Afin d'obtenir une session GDKP de quelqu'un, il doit l'exporter dans |c00FFF569/gdkp où il sélectionne le format « Partager (peut être importé par d'autres joueurs) »";
L["You're about to import a GDKP session created by %s, are you sure?"] = "Vous êtes sur le point d'importer une session GDKP créée par %s, êtes-vous sûr ?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "Cette session GDKP créée par %s semble déjà exister, souhaitez-vous la remplacer ?";
L["Invalid data provided for GDKP extension!"] = "Données invalides fournies pour l'extension GDKP !";
L["Invalid data provided for GDKP reschedule!"] = "Données non valides fournies pour la reprogrammation du GDKP !";
L["Invalid data provided for GDKP shortening!"] = "Données non valides fournies pour le raccourcissement du GDKP !";
L["Invalid data provided for GDKP auction start!"] = "Données non valides fournies pour le début des enchères GDKP !";
L["Invalid number provided for 'paid'"] = "Numéro fourni non valide pour « payé »";
L["Invalid time provided in Auction:reschedule"] = "Heure non valide indiquée dans Auction:reschedule";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP Données (vendu %sx)
Dernière vente pour : %s
Prix moyen : %s
Enchère minimum : %s
Incrément : %s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "Solde : |c0092FF000 ? Tu es quitte ! | |c00BE333330 ? vous devez %s 50g | |c00F7922E50 ? %s vous doit 50g";
L["Gold mailed to you by %s"] = "De l'or vous a été envoyé par %s";
L["Gold paid to %s"] = "Or payé à %s";
L["Gold received from %s"] = "Or reçu de %s";
L["Gold %s by"] = "Or %s par"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "Pot total : %spo | Part organisation : %spo (%s%%) | À distribuer : %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s | Par %s%s | Le |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "La session GDKP n'est pas disponible ou verrouillée";
L["Mail All"] = "Envoyer tout";
L["No bids on Legendary+ item detected, continue manually!"] = "Aucune enchère sur objet légendaire+ détectée, continuez manuellement !";
L["Missing content in Auction:start"] = "Contenu manquant dans les Auction:start";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

Avec les enchères multiples (ou enchères par lots), vous pouvez vendre aux enchères autant d'objets que vous le souhaitez à la fois !
Cela accélère considérablement vos soirées de raid et offre une expérience fluide à vos raideurs.

Tous les objets échangeables encore dans votre inventaire peuvent être automatiquement mis aux enchères avec « Remplir à partir de l'inventaire »
En avant !

|c00808080Il n'y a qu'un seul inconvénient : pour que les gens puissent participer à une vente aux enchères par lots, les raideurs auront besoin de Gargul !

]];
L["You need to have an active (unlocked) GDKP session!"] = "Vous devez avoir une session GDKP active (déverrouillée) !";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "Avec cette fenêtre ouverte, %s les objets pour les ajouter à la liste ou cliquez sur « Remplir depuis l'inventaire » ci-dessous"; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "Anti-snipe en secondes";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "La valeur anti-snipe doit être 0 (vide) ou >=5";
L["Go back to the item selector"] = "Retourner au sélecteur d'objets";
L["Remove all items from the list"] = "Supprimer tous les objets de la liste";
L["Fill from inventory"] = "Remplir à partir de l'inventaire";
L["Add tradeable items from your inventory to the list"] = "Ajoutez des objets échangeables de votre inventaire à la liste";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
Ici, vous déterminez quels objets inclure dans votre session multi-enchères

Utilisez le bouton |c00A79EFFRemplir depuis l'inventaire ci-dessous pour ajouter des objets qui peuvent encore être échangés à la liste.
Chaque fois que vous effacez et rouvrez cette fenêtre, vos derniers paramètres de remplissage seront utilisés pour ajouter automatiquement des éléments.

|c00A79EFF%s les objets pour les ajouter manuellement à la liste
]];
L["Next step: check raider's add-on version for compatibility"] = "Étape suivante : vérifier la compatibilité de la version de l'addon des raideurs";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "Tout le monde n'utilise pas Gargul, êtes-vous sûr de vouloir lancer l'enchère ?";
L["Select at least one item for your auction"] = "Sélectionnez au moins un article pour votre enchère";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Votre Gargul est obsolète, nous vous recommandons de le mettre à jour avant de démarrer une session pour éviter tout problème !";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "Tout le monde n'est pas à jour. Si vous rencontrez des problèmes, dites à vos raiders de se mettre à jour !";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "Il y a une multi-enchère active, les articles que vous ajoutez ici seront ajoutés à la session existante. Attention aux éléments en double !";
L["Search name or iLVL"] = "Rechercher un nom ou iLvl";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "Prend en charge les noms d'objets et iLvl, par ex. '252', '<252', etc.";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "Session GDKP active : |c00967FD2%s | Par %s%s | Le |c00967FD2%s";
L["Auction time in seconds"] = "Durée des enchères en secondes";
L["The auction time in seconds needs to be >= 10"] = "La durée de l'enchère en secondes doit être >= 10";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "Vous êtes parti pendant votre session d'enchères GDKP. Afin de le reprendre vous devez fournir un nouveau délai d'enchère (en secondes) pour les éventuels invendus.";
L["With this window open, %s items to add them to the list"] = "Avec cette fenêtre ouverte, %s les objets pour les ajouter à la liste";
L["Click the cogwheel icon to manage an auction"] = "Cliquez sur l'icône en forme de roue dentée pour gérer une enchère";
L["You're already the top bidder on %s"] = "Vous êtes déjà le meilleur enchérisseur sur %s";
L["Bid |c00%s%sg\nBy %s"] = [[
Enchère |c00%s%sg
Par %s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%sFERMÉE
Aucune offre]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
Minimum : |c00%s%sg
Incrément : |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "Objets : %s - Total vendu : %spo - Promis par moi : %spo";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
Objets avec enchères : %s/%s
Total vendu : %s
Acheté par moi : %s
Enchère totale (n'inclut pas les ventes) : %s
Enchère par moi (n'inclut pas les ventes) : %s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%sVENDU à
%s pour |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
Enchère |c00%s%sg
Par |c0092FF00VOUS !]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "Impossible d'arrêter les enchères automatiques pour %s, réessayez ou /reload !";
L["Auto bid up to a maximum of %sg"] = "Enchère automatique jusqu'à un maximum de %spo";
L["Auto bid up to the bid you fill in on the left"] = "Enchérissez automatiquement jusqu'à l'enchère que vous remplissez à gauche";
L["Stop your auto bid (%sg)"] = "Arrêtez votre enchère automatique (%spo)";
L["Bid on %s could not be confirmed"] = "L'enchère sur %s n'a pas pu être confirmée";
L["Invalid bid or bid is too low! The minimum is %sg"] = "Enchère invalide ou enchère trop basse ! Le minimum est %spo";
L["You need to wait two seconds between bids on the same item"] = "Vous devez attendre deux secondes entre les enchères sur le même objet";
L["Clear bids"] = "Effacer les enchères";
L["Remove all bids from the auction"] = "Supprimer toutes les offres de l'enchère";
L["Close all"] = "Tout fermer";
L["Close ALL auctions?"] = "Fermer TOUTES les enchères ?";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Fermer TOUTES les enchères

Les enchères avec des offres actives seront vendues et ne pourront pas recevoir de nouvelles offres !
]];
L["Close Auction"] = "Clôturer les enchères";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "Clôturez les enchères. Les joueurs ne peuvent plus enchérir mais l'enchère la plus élevée reste active";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "Supprimez l'objet de l'enchère, y compris les détails de son offre. CELA NE PEUT PAS ÊTRE ANNULE !";
L["Disenchant all finished but unsold items?"] = "Désenchanter tous les objets finis mais invendus ?";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
Désenchanter les invendus

Cela marquera tous les objets invendus comme désenchantés et ils n'apparaîtront pas dans une nouvelle session d'enchères multiples.
]];
L["Favorite this item"] = "Favoriser cet article";
L["Give a final call timer of how many seconds?"] = "Donner un minuteur de dernier appel de combien de secondes ?";
L["The minimum amount of seconds is 5"] = "Le nombre minimum de secondes est de 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "Lancez un dernier appel pour cette enchère en donnant un délai d'enchère (généralement plus court)";
L["Close ALL auctions and wrap up this multi-auction session?"] = "Clôturer TOUTES les enchères et conclure cette session multi-enchères ?";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Terminer la session d'enchères multiples

Cela clôturera toutes les enchères et annoncera le pot total dans le chat.
Les enchères avec des offres actives seront vendues et ne pourront pas recevoir de nouvelles offres !
]];
L["Hide inactive"] = "Masquer les inactifs";
L["Hide unusable"] = "Masquer inutilisable";
L["Show/Hide finished auctions"] = "Afficher/Masquer les enchères terminées";
L["Manage Auction"] = "Gérer les enchères";
L["Bid the minimum required amount"] = "Enchérissez sur le montant minimum requis";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "Fenêtre d'enchères fermée, utilisez |c00A79EFF/gl bid pour la rouvrir !";
L["Announce sales in chat"] = "Annoncer les ventes dans le chat";
L["Play sound when outbid"] = "Jouer du son en cas de surenchère";
L["More sound options..."] = "Plus d'options sonores...";
L["Show all"] = "Afficher tout";
L["Show favorites"] = "Afficher les favoris";
L["Show inactive"] = "Afficher inactif";
L["Show unusable"] = "Afficher inutilisable";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "Cet article a été vendu. Utilisez le grand livre (|c00%s/gdkp) pour apporter des modifications !";
L["Terminate"] = "Terminer";
L["Remove all bidsl bids and close all auctions?"] = "Retirer toutes les enchères et clôturer toutes les mises à prix ?";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
Terminer la session d'enchères multiples

Cela supprimera toutes les enchères sur les objets qui n'ont pas encore été vendus et clôturera toutes les enchères !
]];
L["Hover over any of the buttons below for more information"] = "Passez la souris sur l'un des boutons ci-dessous pour plus d'informations";
L["Show/Hide items you can't use"] = "Afficher/masquer les objets que vous ne pouvez pas utiliser";
L["Invalid data provided for GDKP auction start!"] = "Données non valides fournies pour le début des enchères GDKP !";
L["%s bought %s for %s"] = "%s a acheté %s pour %spo";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "Le maître du butin (%s) est obsolète, cela peut entraîner l'échec des enchères !";
L["You were outbid!"] = "Vous avez surenchéri !";
L["Mutators"] = "Mutateurs";
L["Add Mutator"] = "Ajouter mutateur";
L["Auto apply to"] = "Appliquer automatiquement à";
L["Create a new GDKP mutator"] = "Créer un nouveau mutateur GDKP";
L["Delete. Hold shift to bypass confirmation"] = "Supprimer. Maintenez SHIFT pour contourner la confirmation";
L["Edit mutator"] = "Modifier mutateur";
L["Flat gold rate [example: 250]"] = "Montant d'or forfaitaire [exemple : 250]";
L["The flat rate needs to be a number"] = "Le montant forfaitaire doit être un nombre";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
Exemple:
|c00967FD2SELF,RL,HEALER]];
L["You can automatically apply this mutator to raiders using keywords:"] = "Vous pouvez appliquer automatiquement ce mutateur aux raiders en utilisant des mots-clés :";
L["Name [example: Tanks]"] = "Nom [exemple : Tanks]";
L["Mutator names can not contains dots (.)"] = "Le nom des mutateurs ne peuvent pas contenir de points (.)";
L["Percentage [example: 10]"] = "Pourcentage [exemple : 10]";
L["The percentage needs to be a number"] = "Le pourcentage doit être un nombre";
L["Store for future sessions"] = "Stocker pour les prochaines sessions";
L["Unknown mutator: %s"] = "Mutateur inconnu : %s";
L["User '%s' is not allowed to start auctions"] = "L'utilisateur '%s' n'est pas autorisé à lancer des enchères";
L["User '%s' is not allowed to stop auctions"] = "L'utilisateur '%s' n'est pas autorisé à arrêter les enchères";
L["User '%s' is not allowed to stop auction: auction invalid"] = "L'utilisateur '%s' n'est pas autorisé à arrêter l'enchère : enchère invalide";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "Il n'y a pas assez d'or à distribuer, attendez-vous à des calculs de parts bizarres !";
L["No bids!"] = "Aucune offre !";
L["You were outbid!"] = "Vous avez surenchéri !";
L["(active)"] = "(actif)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
Vous devez être chef de groupe ou maître du butin pour ajuster l'or.
Vous ne pouvez pas ajuster l'or sur les sessions verrouillées/supprimées]];
L["Add/Remove gold"] = "Ajouter/Supprimer de l'or";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s a payé |c00%s%s pour
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Supprimé par %s
Motif :]];
L["(deleted)"] = "(supprimé)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
Vous devez être chef de groupe ou maître du butin pour supprimer des entrées.
Vous ne pouvez pas supprimer des entrées sur des sessions verrouillées/supprimées]];
L["Provide a reason for deleting this entry"] = "Indiquez la raison de la suppression de cette entrée";
L["Delete. Hold shift to bypass note"] = "Supprimer. Maintenez Shift pour contourner la note";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "Les sessions auxquelles sont attachées des enchères seront supprimées après 48 heures.";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
Vous devez être chef de groupe ou maître du butin pour modifier les entrées.
Vous ne pouvez pas modifier les entrées supprimées ou les entrées sur les sessions verrouillées/supprimées]];
L["Export a session so others can view session details or even replace you as a loot master"] = "Exportez une session pour que d'autres puissent voir les détails de la session ou même vous remplacer en tant que maître du butin";
L["Import a session from another player or account"] = "Importer une session depuis un autre joueur ou compte";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
Afficher un aperçu complet de l'historique,
idéal pour les captures d'écran !]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "Verrouiller une session signifie que vous ne pouvez pas mettre d'objets aux enchères ou modifier quoi que ce soit jusqu'à ce que vous la déverrouilliez, en êtes-vous sûr ?";
L["Lock or unlock the session"] = "Verrouiller ou déverrouiller la session";
L["Lock the session for payout"] = "Verrouiller la session pour le paiement";
L["Multi-auction: auction multiple items at once!"] = "Enchères multiples : mettez aux enchères plusieurs objets à la fois !";
L["added to"] = "ajouté à";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s pot par %s
Remarques]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "retiré de";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
Pot : %s
Part organisation (%s%%) : %spo
Part par joueur (1/%s) : %spo
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
Vous devez être chef de groupe ou maître du butin pour restaurer les entrées.
Vous ne pouvez pas restaurer les entrées des sessions verrouillées/supprimées]];
L["By %s%s | On |c00%s%s%s"] = "Par %s%s | Le |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "Débloquer et modifier le pot ou les parts peut s'avérer très compliqué, surtout si vous avez déjà effectué des paiements. Es-tu sûr ?";
L["Unlock the session"] = "Débloquez la session";
L["No active GDKP session detected or session is not locked for payout!"] = "Aucune session GDKP active détectée ou la session n'est pas verrouillée pour le paiement !";
L["Increment or minimum can't be lower than .0001!"] = "L'incrément ou le minimum ne peut pas être inférieur à 0,0001 !";
L["Invalid 'Increment' provided for item ID '%s'"] = "'Incrément' non valide fourni pour l'ID d'objet '%s'";
L["Invalid 'Minimum' provided for item ID '%s'"] = "« Minimum » non valide fourni pour l'ID d'objet « %s »";
L["Either minimum or increment is required for item ID: %s"] = "Un minimum ou un incrément est requis pour l'ID d'objet : %s";
L["Missing header, note: it's case-sensitive!"] = "En-tête manquant, attention : il est sensible à la casse !";
L["Successfully imported data for %s items"] = "Données importées avec succès pour %s objets";
L["Unknown item ID: %s"] = "ID d'objet inconnu : %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s dans des sacs, des fenêtres de butin ou même sur des liens dans votre chat pour les ajouter à cette file d'attente d'enchères.
Les objets dans la file d'attente seront automatiquement mis aux enchères une fois votre enchère en cours terminée. Cliquez sur le bouton '%s' pour éviter cela.

Vous voulez que Gargul attribue ou désenchante automatiquement les enchères pour vous ? Ouvrez la roue des paramètres sur le côté gauche !

|c00FFF569Le saviez-vous ?
Vous pouvez déplacer des objets par glisser-déposer
Les objets seront mémorisés, même lorsque vous |c00A79EFF/reload
Les objets en file d'attente sont automatiquement présentés aux raideurs qui possèdent Gargul afin qu'ils puissent pré-enchérir.
Gargul peut également gérer la fouille automatique pour vous. Découvrez-la avec |c00A79EFF/gl pm
]];
L["Hide unusable items"] = "Masquer les objets inutilisables";
L["GDKP Session"] = "Session GDKP";
L["Editing %s"] = "Modification de %s";
L["Show upcoming items"] = "Afficher les objets à venir";
L["Stop the auction first!"] = "Arrêtez d'abord les enchères !";
L["%s owes you %s"] = "%s vous doit %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP Séance
Dépensé par le joueur : %s
Donné : %s
Reçu : %s
Joueur supprimé : %s

%s
]];
L["Exclude from GDKP"] = "Exclure du GDKP";
L["Gold traded will not be added to amount given or received"] = "L'or échangé ne sera pas ajouté au montant donné ou reçu";
L["Gold |c00967FD2given to %s"] = "Or |c00967FD2donné à %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "Impossible d'ajouter %s à la fenêtre d'échange. Essayez de l'ajouter manuellement !";
L["You don't have enough money to pay %s"] = "Vous n'avez pas assez d'argent pour payer %s";
L["To give: %s"] = "À donner : %s";
L["To receive: %s"] = "À recevoir : %s";
L["Gold |c00967FD2received from %s"] = "Or |c00967FD2reçu de %s";
L["Check out Multi Auctions!"] = "Découvrez les enchères multiples !";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "Suivez les étapes ci-dessous pour démarrer rapidement avec Gargul GDKP !";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "Activez cette session en cliquant sur le bouton |c00FFF569Activer ci-dessous !";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s un objet pour mettre aux enchères ou mettre en file d'attente un seul article"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
Commandes utiles :
- |c00FFF569/gdkp pour ouvrir cette fenêtre
- |c00FFF569/gl ma pour ouvrir la fenêtre multi-enchères
- |c00FFF569/gl au pour ouvrir la fenêtre d'enchères/la file d'attente d'un seul objet
- |c00FFF569/gl pm pour configurer la fouille automatique

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "Si tout s'est bien passé, vous verrez ici vos objets fraîchement mis aux enchères !";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "Vous souhaitez mettre aux enchères plusieurs objets à la fois ? Exécutez |c00FFF569/gl ma (ou |c00FFF569/gl multiauction) ou cliquez sur l'icône multi-enchères en haut à droite de cette fenêtre !";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "Cliquez sur le bouton |c00FFF569New ci-dessous pour créer votre première session GDKP. Il s'affichera à gauche une fois créé";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "Vous êtes prêt à vendre des objets ! |c00BE3333Lisez attentivement toutes les étapes ci-dessous et testez-les toutes par vous-même (pas besoin d'être dans un raid) avant de commencer votre premier raid GDKP !";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "Vous souhaitez vendre un objet sans que personne n'enchérisse ? |c00FFF569%s sur un objet, choisissez un gagnant et fixez un prix !";
L["Getting started"] = "Commencer";
L["Unknown itemID in Auction:create: %s"] = "ID d'objet inconnu dans l'enchère : créer : %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "Identifiant de session inconnu dans l'enchère : créer : %s";
L["You owe %s %s"] = "Vous devez %s %s";
L["Given"] = "Donné";
L["g"] = "po";
L["Group"] = "Groupe";
L["Group Manager"] = "Gestionnaire de groupes";
L["Download on CurseForge"] = "Télécharger sur CurseForge";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "Arrêt";
L["Header"] = "En-tête";
L["v%s. Type |c00967FD2/gl|r or |c00967FD2/gargul|r to get started!"] = "v%s. Tapez |c00967FD2/gl|r ou |c00967FD2/gargul|r pour commencer !";
L["Hide"] = "Cacher";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Visitez l'URL ci-dessous pour en savoir plus sur la personnalisation des GDKP Gargul.";
L["Your logo here? Click for more info!"] = "Votre logo ici ? Cliquez pour plus d'informations !";
L["Import"] = "Importer";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "Importé le |c00A79EFF%s à |c00A79EFF%s, mis à jour le |c00A79EFF%s à |c00A79EFF%s";
L["What kind of data would you like to import?"] = "Quel type de données souhaitez-vous importer ?";
L["Import of boosted roll data successful"] = "Importation réussie des données de lancers améliorés";
L["Inc"] = "Inc.";
L["Include previously awarded items"] = "Inclure les objets précédemment attribués";
L["Include BOEs"] = "Inclure les LQE";
L["Include materials (like Abyss Crystals)"] = "Inclure des matériaux (comme les cristaux des Abysses)";
L["Increment"] = "Incrément";
L["Info"] = "Info";
L["Invalid data supplied"] = "Données non valides fournies";
L["Item"] = "Objet";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Impossible de décoder les données JSON. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Raccourcis clavier pour les objets Gargul

Démarrer les lancers : |c00A79EFF%s
Attribuer : |c00A79EFF%s
Désenchanter : |c00A79EFF%s


-- Faites un clic droit pour désactiver cette fenêtre --
]];
L["Ledger"] = "historique";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "Vous devez être le maître du butin ou avoir un rôle d'assistant/chef de groupe !";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "Remarque : vous pouvez modifier la langue à tout moment dans les paramètres ou via |c00%s/gl locale";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul publie des messages de discussion en anglais (par défaut)
Vous pouvez sélectionner une autre langue dans la liste déroulante ci-dessous

Votre langue de discussion actuelle est '%s', l'activation d'une langue différente entraînera un /reload !
]];
L["Choose a chat language for Gargul"] = "Choisissez une langue de discussion pour Gargul";
L["ptBR"] = "ptBR"; -- Portuguese (Brazil)
L["ruRU"] = "ruRU"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "Vous avez installé un ou plusieurs modules complémentaires qui peuvent potentiellement provoquer un dysfonctionnement de Gargul : %s";
L["Clear SoftRes"] = "Effacer SoftRes";
L["Clear TMB"] = "Effacer TMB";
L["/roll for MS or /roll 99 for OS"] = "/roll pour MS ou /roll 99 pour OS";
L["Import SoftRes"] = "Importer SoftRes";
L["Import TMB"] = "Importer TMB";
L["You were given the role of Master Looter"] = "On vous a confié le rôle de maître du butin";
L["Open this window automatically"] = "Ouvrir cette fenêtre automatiquement";
L["Loot priorities cleared successfully"] = "Les priorités de butin ont été effacées avec succès";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "Fournissez un CSV prio au format suivant (1 ligne par objet) : id ou nom > prio1, equalprio > prio2 > etc";
L["Loot priorities imported successfully"] = "Priorités de butin importées avec succès";
L["Invalid data provided"] = "Données non valides fournies";
L["Invalid data provided in line: '%s': missing item id or priority"] = "Données non valides fournies à la ligne : '%s' : identifiant ou priorité d'objet manquant";
L["Attempting to process incoming loot priorities from %s"] = "Tentative de traitement des priorités de butin entrantes de %s";
L["Loot Prio"] = "Priorité de butin";
L["Mail"] = "Mail";
L["Mailed"] = "Envoyé par la poste";
L["Mail cut to players"] = "Poster part aux joueurs";
L["MS"] = "+1";
L["Maximize"] = "Maximiser";
L["Min"] = "Min.";
L["Awarded loot history"] = "Historique attributions";
L["GDKP Cuts"] = "Parts GDKP";
L["Export data"] = "Exporter données";
L["Open Gargul"] = "Ouvrir Gargul";
L["Import data"] = "Importer données";
L["GDKP Ledger"] = "Historique GDKP";
L["Multiauction"] = "Multi-enchères";
L["Change settings in /gl minimap"] = "Modifier les paramètres dans la mini-carte /gl";
L["Minimize"] = "Minimiser";
L["Minimize on award"] = "Réduire lors de l'attribution";
L["Minimize on start"] = "Réduire au démarrage";
L["Minimum"] = "Minimum";
L["Minimum item level"] = "Niveau d'objet minimum";
L["Minimum Quality"] = "Qualité minimale";
L["-10"] = "-dix";
L["-"] = "-";
L["Move"] = "Déplacer";
L["Multi-Auction"] = "Multi-enchères";
L["Name"] = "Nom";
L["New"] = "Nouveau";
L["Next"] = "Suivant";
L["No"] = "Non";
L["None"] = "Aucun";
L["Note"] = "Note";
L["Nothing"] = "Rien";
L["When no one bids do:"] = "Quand personne n'enchérit, faites :";
L["You don't have officer privileges"] = "Vous n'avez pas de privilèges d'officier";
L["OS"] = "+2";
L["Ok"] = "OK";
L["Open"] = "Ouvrir";
L["Open Auctioneer"] = "Ouvrir fenêtre d'enchères";
L["Open Multi-Auction"] = "Ouvrir enchères multiples";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "Définir %s comme désenchanteur ?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "Envoyer %s à %s ? Tapez /gl cd pour supprimer ce désenchanteur !";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "Aucun désenchanteur défini, utilisez /gl sd [mydisenchanter] pour en définir un";
L["Who is your disenchanter?"] = "Qui est votre désenchanteur ?";
L["Paid"] = "Payé";
L["Pass"] = "Passer";
L["%"] = "%";
L["Player"] = "Joueur";
L["Items won by %s:"] = "Objets gagnés par %s :";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "+1";
L["Add a +1"] = "Ajouter un +1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "Êtes-vous sûr de vouloir diffuser vos données +1 à tous les membres de votre groupe/raid ?";
L["Attempting to process incoming PlusOnes data from %s"] = "Tentative de traitement des données +1 entrantes provenant de %s";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s souhaite effacer toutes vos données +1. Effacer toutes les données ?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "Êtes-vous sûr de vouloir effacer vos données +1 existantes et importer de nouvelles données diffusées par %s ?";
L["Are you sure you want to import new data broadcasted by %s?"] = "Etes-vous sûr de vouloir importer les nouvelles données diffusées par %s ?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Données non valides fournies. Assurez-vous que le contenu suit le format requis et qu'aucune ligne d'en-tête n'est incluse.";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
Ici, vous pouvez importer les données +1 d'un tableau au format CSV ou TSV ou collée à partir d'une feuille Google Docs.

Le tableau nécessite au moins deux colonnes : Le nom du joueur suivi du nombre de points. Les colonnes supplémentaires sont ignorées.

Voici un exemple de ligne :

Foobar,240
]];
L["Automatically accept incoming broadcasts from %s"] = "Accepter automatiquement les diffusions entrantes de %s";
L["Block all incoming +1 shared data"] = "Bloquer toutes les données partagées +1 entrantes";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Êtes-vous sûr de vouloir mettre à jour vos données +1 existantes avec les données de %s ?

Votre dernière mise à jour était sur |c00A79EFF%s, la leur sur |c00A79EFF%s.]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "Pot";
L["Price"] = "Prix";
L["PL"] = "LP";
L["Common"] = "Commun";
L["Epic"] = "Épique";
L["Heirloom"] = "Héritage";
L["Legendary"] = "Légendaire";
L["Poor"] = "Médiocre";
L["Rare"] = "Rare";
L["Uncommon"] = "Inhabituel";
L["Queue"] = "File d'attente";
L["Raiders"] = "Raideurs";
L["Who's Missing"] = "Qui manque";
L["Show missing player names"] = "Afficher les noms des joueurs manquants";
L["Disband raid"] = "Dissoudre le raid";
L["Disband your raid"] = "Dissoudre votre raid";
L["%s is listed twice on the roster!"] = "%s est répertorié deux fois sur la liste !";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "un export |c00FFF569Raid-Helper (Utilisez la variante 'Groupes triés verticalement') ou un CSV de composition de groupe |c00FFF569Gargul :";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
Dans la zone d'édition ci-dessous, vous pouvez fournir une liste et : inviter tout le monde, vérifier qui manque, appliquer des groupes et attribuer les tanks.

Vous pouvez fournir un lien de composition de raid |c00FFF569Wowhead :]];
L["Gargul Group Wiki"] = "Wiki des Groupes Gargul";
L["Visit the Gargul group wiki for more info on the raid group format"] = "Visitez le wiki des Groupes Gargul pour plus d'informations sur le format des groupes de raid.";
L["The following players are not part of the roster: %s"] = "Les joueurs suivants ne font pas partie de la liste : %s";
L["Invalid group data provided, check your format!"] = "Données de groupe fournies non valides, vérifiez votre format !";
L["Invite"] = "Inviter";
L["Send invites to players on roster"] = "Envoyer des invitations aux joueurs inscrits sur la liste";
L["Can't sort groups while %s is in combat!"] = "Impossible de trier les groupes pendant que %s est en combat !"; -- %s holds a player name
L["You need to be in a raid!"] = "Vous devez participer à un raid !";
L["No tanks defined"] = "Aucun tank défini";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "Vous ne trouvez pas de place pour %s, essayez-vous de mettre plus de 5 personnes dans 1 groupe ?";
L["Kick unwanted players"] = "Expulser indésirables";
L["Kick players that aren't on the roster"] = "Expulser les joueurs qui ne sont pas sur la liste";
L["Something went wrong while moving %s"] = "Quelque chose s'est mal passé lors du déplacement de %s";
L["Finished applying raid roster"] = "Fin de l'application de la liste de raid";
L["Sorting groups"] = "Trier groupes";
L["Apply Groups"] = "Appliquer groupes";
L["Sort groups based on roster"] = "Trier les groupes en fonction de la liste";
L["Sorting is still in progress, wait a bit!"] = "Le tri est toujours en cours, attendez un peu !";
L["All tanks are assigned"] = "Tous les tanks sont attribués";
L["Assign Tanks"] = "Attribuer tanks";
L["Wowhead Comp Tool"] = "Outil de Composition Wowhead";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "Vous pouvez visiter l'outil de composition de raid Wowhead en utilisant l'URL ci-dessous. Après avoir créé votre composition, vous pouvez la coller ici ou dans le champ d'édition de la fenêtre du gestionnaire de groupes de Gargul.";
L["Remove bid"] = "Supprimer l'enchère";
L["Reset Settings"] = "Réinitialiser options";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "Êtes-vous sûr de vouloir réinitialiser tous les paramètres de Gargul ? Cela ne peut pas être annulé !";
L["Reset Gargul UI"] = "Réinitialiser interface";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "Êtes-vous sûr de vouloir réinitialiser toutes les tailles, positions et échelles de fenêtres de Gargul ? Cela ne peut pas être annulé !";
L["Restore"] = "Restaurer";
L["Resume"] = "Reprendre";
L[">"] = ">";
L["Roll"] = "Lancer";
L["Award %s to %s?"] = "Attribuer %s à %s ?";
L["Close on award"] = "Fermer à l'attribution";
L["Close on start"] = "Fermer au démarrage";
L["Hold shift to bypass the award confirmation"] = "Maintenez Shift pour contourner la confirmation d'attribution";
L["Hold shift to show the award confirmation"] = "Maintenez Shift pour afficher la confirmation d'attribution";
L["Warning: another identical roll was found which can point to a tie"] = [[
Attention : un autre lancer identique a été trouvé qui peut indiquer une égalité

]];
L["Invalid data provided for roll start!"] = "Données invalides fournies pour le début des lancers !";
L["(BR: %s)"] = "(LA : %s)";
L["(item given: yes)"] = "(objet donné : oui)";
L["(item given: no)"] = "(objet donné : non)";
L["(OS)"] = "(+1)";
L["NOTE"] = "NOTE";
L["Can't stop roll off, no roll off in progress"] = "Impossible d'arrêter le lancer, aucun lancer en cours";
L["Pass"] = "Passer";
L["rolls: %s"] = "lancers : %s";
L["Open master looter window"] = "Ouvrir la fenêtre de maître du butin";
L["Roll accepted!"] = "Lancer accepté !";
L["A roll is currently in progress"] = "Un lancer est actuellement en cours";
L["Prio [%s]"] = "Priorité [%s]";
L["SR [%sx]"] = "SR [%sx]";
L["Wish [%s]"] = "Souhait [%s]";
L["You need to select a player first"] = "Vous devez d'abord sélectionner un joueur";
L["TIMER (s)"] = "Temps";
L["You can't use this item!"] = "Vous ne pouvez pas utiliser cet objet !";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "Le nom du gagnant n'est pas unique, sélectionnez le joueur à qui vous souhaitez attribuer %s";
L["s"] = "s";
L["Select / Disable all"] = "Sélectionner / désactiver tout";
L["Session"] = "Session";
L["Settings"] = "Paramètres";
L["Announce incoming bids"] = "Annoncer les enchères entrantes";
L["Announce pot after awarding item"] = "Annoncer le pot après avoir attribué l'objet";
L["Announce auction start"] = "Annoncer le début des enchères";
L["Announce countdown in raid warning"] = "Annoncer le compte à rebours dans l'avertissement de raid";
L["Announce incoming bids in raid warning"] = "Annoncer les enchères entrantes dans l'avertissement de raid";
L["Reset Gargul UI"] = "Réinitialiser l'interface utilisateur de Gargul";
L["Whisper bidder if bid is too low"] = "Chuchoter l'enchérisseur si l'offre est trop basse";
L["s"] = "pa";
L["Skip"] = "Passer";
L["Soft-Reserves"] = "Soft Reserve";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "Etes-vous sûr de vouloir diffuser vos données softres à tous les membres de votre groupe/raid ?";
L["Couldn't process SoftRes data received from %s"] = "Impossible de traiter les données SoftRes reçues de %s";
L["Are you sure you want to clear all existing soft-reserve data?"] = "Êtes-vous sûr de vouloir effacer toutes les données de soft-reserve existantes ?";
L["Everyone filled out their soft-reserves"] = "Tout le monde a rempli ses soft-reserves";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
Les informations sur les hard-reserves ne sont pas disponibles car les soft-reserves
fournis n'ont pas été générés à l'aide du bouton 'Gargul Export' sur softres.it]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "Importé le |c00A79EFF%s à |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "Correction automatique du nom : le SR de '%s' est désormais lié à '%s'";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "Pour commencer, vous devez d'abord créer un raid sur softres.it. Cliquez ensuite sur « Addon Export », sélectionnez « Gargul », copiez les données et collez-les dans le formulaire ci-dessous.";
L["Invalid soft-reserve data provided"] = "Données soft-reserve fournies invalides";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "Données non valides fournies. Assurez-vous de cliquer sur le bouton « Gargul Export » sur softres.it et collez le contenu complet ici";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "Les valeurs +1 fournies sont en conflit avec celles déjà présentes. Voulez-vous remplacer vos anciennes valeurs +1 ?";
L["The following players did not reserve anything:"] = "Les joueurs suivants n'ont rien réservé :";
L["Soft-reserves imported successfully"] = "Soft-reserves importées avec succès";
L["Import successful!"] = "Importation réussie !";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "Les données SoftRes Weakaura et CSV sont obsolètes, utilisez plutôt l'exportation Gargul !";
L["Failed to connect to LootReserve, contact support (include message below)"] = "Échec de la connexion à LootReserve, contactez l'assistance (inclure le message ci-dessous)";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "Aucune URL softres.it disponible, assurez-vous d'avoir exporté en utilisant le bouton 'Gargul Export' sur softres.it !";
L["Click here to see hard-reserve info"] = "Cliquez ici pour voir les informations sur les hard-reserves";
L["No items are hard-reserved"] = "Aucun objet n'est hard-reseve";
L["No hard-reserve info available"] = "Aucune information de hard-reserve disponible";
L["Post missing SRs"] = "Publier SR manquants";
L["Post SR URL"] = "URL de la publication SR";
L["This player did not reserve anything!"] = "Ce joueur n'a rien réservé !";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "Tentative de traitement des données SoftRes entrantes de %s";
L["This item is hard-reserved"] = "Cet objet est hard-réserved";
L["For: %s"] = "Pour : %s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 Remarque : %s";
L["Reserved by"] = "Réservé par";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "Quelque chose s'est mal passé !";
L["Start"] = "Commencer";
L["Stop"] = "Arrêter";
L["\\t is replaced by a tab"] = "\\t est remplacé par une tabulation";
L["TMB"] = "TMB";
L["Time"] = "Temps";
L["Title"] = "Titre";
L["TMB, DFT or PRIO3"] = "TMB, DFT ou PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "Êtes-vous sûr de vouloir diffuser vos données TMB à tous les membres de votre groupe/raid ? NB : TOUT LE MONDE peut voir vos données TMB quelles que soient ses autorisations sur le site de TMB !";
L["Attempting to process incoming TMB data from %s"] = "Tentative de traitement des données TMB entrantes de %s";
L["Are you sure you want to clear all plus one data?"] = "Êtes-vous sûr de vouloir effacer toutes les données +1 ?";
L["Clear Raider Data"] = "Effacer données raideurs";
L["Clear TMB data for all raiders?"] = "Effacer les données TMB pour tous les raiders ?";
L["Auto-sharing enabled: %s"] = "Partage automatique activé : %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Sur votre exécution classicpr.io, cliquez sur le bouton « Gargul Export » et copiez le contenu. Collez ensuite le contenu tel quel dans la case ci-dessous et cliquez sur « Importer ». C'est tout !";
L["Imported on ${date} at ${time}"] = "Importé le ${date} à ${time}";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Exportez vos données DFT selon les instructions de la feuille. Collez ensuite le contenu tel quel dans la case ci-dessous et cliquez sur « Importer ». C'est ça!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "CSV fourni non valide, le format est : 6948,player1,player2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "Données DFT fournies non valides. Exportez vos données DFT conformément aux instructions de la feuille et collez le contenu ici tel quel !";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "Données TMB fournies non valides, assurez-vous de cliquer sur le bouton « Télécharger » dans la section Gargul et collez le contenu ici tel quel !";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "Données TMB ou DFT fournies non valides. Assurez-vous de coller le contenu de l'exportation ici tel quel !";
L["Priority notes available: %s"] = "Notes de priorité disponibles : %s";
L["Number of items imported: %s"] = "Nombre d'objets importés : %s";
L["The following players have no %s entries:"] = "Les joueurs suivants n'ont pas d'entrée %s :"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "Comment utiliser Gargul avec ${source}";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "Collez le contenu de votre export TMB tel quel dans la case ci-dessous et cliquez sur 'Importer'.";
L["There's no one in your group to broadcast to"] = "Il n'y a personne dans votre groupe vers qui diffuser";
L["TMB data synced"] = "Données TMB synchronisées";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF Note : |c00FFF569%s";
L["(OS)"] = "(+2)";
L["%s Prio List"] = "Liste prioritaire %s"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF Niveau : %s";
L["TMB Wish List"] = "Liste de souhaits TMB";
L["Show/Hide Dates"] = "Afficher/masquer les dates";
L["Show/Hide Queue"] = "Afficher/masquer la file d'attente";
L["%s to award loot!"] = "%s pour attribuer du butin !";
L["%s to roll out loot!"] = "%s pour lancer les dés sur le butin !";
L["Hide all awarded items"] = "Masquer tous les objets attribués";
L["Hide disenchanted items"] = "Cacher les objets désenchantés";
L["Hide items awarded to self"] = "Masquer les objets attribués à soi-même";
L["Announce Trade"] = "Annoncer échange";
L["Announce trade details to group or in /say when not in a group"] = "Annoncer les détails de l'échange au groupe ou dans /dire lorsque vous n'êtes pas dans un groupe";
L["Tutorial"] = "Didacticiel";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s dans les sacs, des fenêtres de butin ou même sur des liens dans votre chat pour les ajouter à la file d'attente des enchères.
Vous souhaitez vendre directement un article sans enchérir ? Utilisez |c00A79EFF%s

Vous pouvez ouvrir la fenêtre %s directement en tapant |c00A79EFF/gl auctions

Gargul suit | c00FF0000TOUS l'or échangé. Vous ne voulez pas qu'un échange fasse partie de cette session GDKP ? Cochez la case « Exclure du GDKP » lors de l'échange !

|c00FFF569Le saviez-vous ?
Les objets attribués seront automatiquement ajoutés à la fenêtre d'échange
Gargul peut également gérer la fouille automatique pour vous. Découvrez-la avec |c00A79EFF/gl pm
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
Cette fenêtre affiche tous les objets qui ont été attribués à une date donnée (sélectionnez une ou plusieurs dates sur la gauche).

Les éléments peuvent contenir les balises suivantes :

|c00A79EFFOS : attribué pour spécialisation secondaire
|c00A79EFFSR : Cet objet était soft-reserved
|c00A79EFFWL : Cet objet était en liste de souhaits (Thatsmybis)
|c00A79EFFPL : Cet objet était en liste de priorité (Thatsmybis, DFT, prio3)
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
Les objets que vous voyez ici sont dans la file d'attente GDKP du maître du butin
Vous pouvez les supprimer, enchérir sur eux et masquer les objets inutilisables (activez « Masquer les objets inutilisables » dans les paramètres en haut à gauche).

Vous pouvez redimensionner la fenêtre, la déplacer ou la réduire. Essaye la !

Pour les maîtres du butin : supprimer des objets ici les supprimera uniquement de votre file d'attente personnelle, pas de la file d'attente GDKP courante !
]];
L["Need more help?"] = "Besoin d'aide ?";
L["Type"] = "Type"; -- As in type of roll or type of item
L["unknown"] = "inconnu";
L["Unknown comm action '%s', make sure to update Gargul!"] = "Action de communication inconnue '%s', assurez-vous de mettre à jour Gargul !";
L["Unlock"] = "Ouvrir";
L["Update Gargul!"] = "Mettez à jour Gargul !";
L["v"] = "v";
L["Report"] = "Rapporter";
L["Report outdated results in group chat"] = "Signaler les résultats obsolètes dans la discussion de groupe";
L["Gargul status"] = "Statut Gargul";
L["Checking version ..."] = "Vérification de la version...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s : le joueur est à jour
|c00F7922Ev%s : le joueur doit mettre à jour ses add-ons
|c00BE3333%s : le joueur n'a pas Gargul ou utilise une version non supportée
|c00808080%s : le joueur est hors ligne ou nous ignore !
|c0000FFFF%s : le joueur est sur notre liste d'ignorés !

]];
L["PLAYER IGNORED!"] = "JOUEUR IGNORÉ !";
L["Offline"] = "Hors-ligne";
L["No response"] = "Pas de réponse";
L["No response:"] = "Pas de réponse:";
L["Offline:"] = "Hors-ligne:";
L["Outdated:"] = "Obsolète:";
L["Up-to-date:"] = "À jour:";
L["Gargul is out of date and won't work until you update!"] = "Gargul est obsolète et ne fonctionnera pas tant que vous n'aurez pas mis à jour !";
L["Invalid version string provided in Version:addRelease"] = "Chaîne de version non valide fournie dans Version : addRelease";
L["Update Gargul!"] = "Mettez à jour Gargul !";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul est maintenant mis à jour vers |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s est disponible sur CurseForge/Wago. Vous pouvez mettre à jour sans fermer votre jeu, assurez-vous simplement de /reload !";
L["Wait %s more seconds before you retry"] = "Attendez %s secondes supplémentaires avant de réessayer";
L["Window"] = "Fenêtre";
L["Gargul v%s"] = "Gargul v%s";
L["Window Scale"] = "Échelle de la fenêtre";
L["WL"] = "WL";
L["Yes"] = "Oui";
L["You disabled GDKP queues"] = "Vous avez désactivé les files d'attente GDKP";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "Impossible de compresser les données avec zlib. Contactez l'assistance via https://discord.gg/D3mDhYPVzf";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Impossible de décompresser les données avec zlib. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
