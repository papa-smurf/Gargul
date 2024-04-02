--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "ptBR") then return; end
local L = Gargul_L or {};

L.ABOUT = "Sobre";
L.ALL_SETTINGS = "Todas as configurações";
L.ANNOUNCE = "Anunciar";
L.ANTISNIPE = "Anti-Snipe";
L.ANTISNIPE_EXPLANATION = [[

Um valor Anti Snipe de 10 significa que qualquer lance que venha com
menos de 10 segundos restantes redefinirá o cronômetro para 10 segundos

Você pode deixar em branco ou definir como 0 para desativar completamente o Anti Snipe.
Valores Anti Snipe inferiores a 5 não são suportados

]];
L.ARE_YOU_SURE = "Tem certeza?";
L.ASSIGN_GARGUL_INFO = [[
Não se esqueça de usar Gargul
se você deseja exportar o saque mais tarde


-- Clique com o botão direito para desativar esta janela --]];
L.AUCTION = "Leilão";
L.AUCTIONEER = "Leiloeiro";
L.AUCTIONS = "Leilões";
L.AUTO = "Auto";
L.AUTO_AWARD = "Prêmio automático";
L.AUTO_TRADE_OPTIONS = "Comércio de automóveis";
L.AVAILABLE_PLACEHOLDER_VALUES = "Valores disponíveis:";
L.AWARD = "Prêmio";
L.AWARDED_TO = "Concedido a";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Preço: %s";
L.AWARDED_TOOLTIP_GIVEN = "Dado: sim";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Dado: não";
L.AWARDED_TOOLTIP_SECOND_BID = "2º lance: %s por %s";
L.AWARDED_YOU_WON = "Você ganhou";
L.AWARD_CONFIRM = "Premiar %s para %s?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Tem certeza de que deseja desencantar %s? %s pontos de rolagem aumentados serão reembolsados!";
L.AWARD_HEADER_IN_GROUP = "Em grupo";
L.AWARD_HISTORY = "História do prêmio";
L.AWARD_NEW_WINNER_CONFIRMATION = "A quem %s deveria recorrer?";
L.AWARD_PLAYER_CUSTOM_NAME = "Digite o nome do jogador aqui";
L.AWARD_PLAYER_SELECT_NAME = "ou selecione um abaixo";
L.AWARD_RANDOM_CONFIRM = "Quer premiar %s a um jogador aleatório?";
L.AWARD_TOOLTIP_ADD_ITEM = "Arraste e solte ou shift+clique em um item na caixa à direita";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Itens desencantados:";
L.AWARD_TOOLTIP_GIVEN = "(Dado: sim)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Dado: não)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(SO)";
L.AWARD_UNDO_BR_REFUND = "%s pontos de rolagem aumentados serão reembolsados!";
L.AWARD_UNDO_CONFIRM = "Tem certeza de que deseja desfazer %s concedidos a %s?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Falha na inspeção da bagagem: nenhum relatório foi recebido";
L.BAGINSPECTOR_FINISHED = "Inspeção concluída";
L.BAGINSPECTOR_START = "Iniciando a inspeção...";
L.BALANCE = "Equilíbrio";
L.BASE = "Base";
L.BASE64_DECODE_WARNING = "Não é possível decodificar dados em base64. Certifique-se de copiar/colar como está, sem adicionar caracteres adicionais ou espaços em branco!";
L.BID = "Oferta";
L.BIDS = "Lances";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. Convidar/classificar automaticamente grupos a partir da inscrição no raid! Clique abaixo ou use |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Recompense os jogadores por serem regulares ou por fazerem um esforço extra! Clique abaixo ou use |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul tem alguns truques na manga que você talvez não conheça. Dê uma olhada!";
L.BONUS_PLUSONES = "3. Gargul inclui mais um sistema de rastreamento! Clique abaixo ou use |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Rolinhos Impulsionados";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Adicione quantos pontos para todos que estão atualmente na raid?

|c00BE3333Use o botão 'Adicionar invasores ausentes' primeiro se quiser que todos ganhem pontos, mesmo aqueles sem uma entrada de rolagem aprimorada!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Nenhum valor de pontos fornecido!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Adicione pontos ao ataque";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Adicionar invasores ausentes";
L.BOOSTED_ROLLS_ALIASES = "Apelido";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Aplicar aliases";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Custo de rolagem aumentado:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Tem certeza de que deseja transmitir seus dados de lançamento aprimorado para todos em seu grupo/raid?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Nada para transmitir, importe primeiro os dados do Boosted Rolls!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Não foi possível processar os dados do BoostedRolls recebidos de %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Tentando processar dados BoostedRolls recebidos de %s";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Tem certeza de que deseja limpar todos os dados de rolagem otimizada?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Excluir %s?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Tem certeza de que deseja limpar os dados existentes de rolagem otimizada e importar novos dados transmitidos por %s?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Dados inválidos fornecidos. Certifique-se de que o conteúdo siga o formato exigido e que nenhuma linha de cabeçalho esteja incluída";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Aqui você pode importar dados e aliases de rolagem otimizados de uma tabela em formato CSV ou TSV ou colados de uma planilha do Google Docs.

A tabela precisa de pelo menos duas colunas: O nome do jogador seguido da quantidade de pontos. Colunas adicionais são opcionais e podem conter apelidos para o player.
Aqui está um exemplo de linha:

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Pontos";
L.BOOSTED_ROLLS_RESERVE = "reserva";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Tem certeza de que deseja atualizar suas listas otimizadas existentes com dados de %s?

Sua atualização mais recente foi em |c00A79EFF%s, a deles em |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bônus|!rb|!br";
L.BROADCAST = "Transmissão";
L.BROADCASTING_NOTIFICATION = "Transmissão...";
L.BROADCAST_DELAYED_BY_COMBAT = "Você está atualmente em combate, atrasando a transmissão";
L.BROADCAST_FINISHED = "Transmissão finalizada!";
L.BROADCAST_INC_AWARDED = "Incluir itens premiados";
L.BROADCAST_INC_DISENCHANTED = "Incluir itens desencantados";
L.BROADCAST_INC_HIDDEN = "Incluir itens ocultos";
L.BROADCAST_INC_TIME_LEFT = "Incluir tempo restante";
L.BROADCAST_IN_PROGRESS_ERROR = "Transmissão ainda em andamento";
L.BROADCAST_NO_DATA = "Não há nada para transmitir";
L.BROADCAST_NUMBER_OF_ITEMS = "Número de ítens";
L.BROADCAST_PROGRESS = "Transmissão ${percentage}%";
L.BROADCAST_TARGET_PLAYER = "Jogador alvo (apenas sussurro)";
L.BROADCAST_TARGET_REQUIRED = "Whisper requer um jogador alvo";
L.BROADCAST_TRADE_TIME_LEFT = "Tempo máximo de negociação restante (em minutos)";
L.BY = "por"; -- As in 'bid BY'
L.CANCEL = "Cancelar";
L.CHANGELOG_CONTRIBUTE = "Obtenha suporte ou compartilhe ideias em nosso Discord";
L.CHANGELOG_ENABLE_LABEL = "Habilitar registro de alterações";
L.CHANGELOG_GETTING_STARTED = "Gargul torna a distribuição de itens muito fácil. Clique no botão abaixo para começar!";
L.CHANGELOG_OPEN_GARGUL = "Abrir Gárgula";
L.CHANGE_SCALE = "Ajustar escala";
L.CHANNEL = "Canal";
L.CHANNEL_OFFICER = "Policial";
L.CHANNEL_RAID_WARNING = "Aviso de invasão";
L.CHANNEL_WHISPER = "Sussurrar";
L.CLASSICPRIO_ABBR = "RCP";
L.CLEAR = "Claro"; -- As in clearing a window or data
L.CLOSE = "Fechar";
L.CLOSE_ON_AWARD = "Fechar no prêmio";
L.CLOSE_ON_START = "Fechar no início";
L.COMMUNICATION = "Comunicação";
L.COMM_PROGRESS = "Enviou %s de %s bytes";
L.COPPER_INDICATOR = "c";
L.CUT = "Corte";
L.CUTS = "Cortes";
L.CUT_MAILBOX_CLOSED = "Não é possível enviar e-mails quando a caixa de correio está fechada";
L.CUT_MAILS_FAILED = "Vários erros de e-mail detectados, abortando a distribuição cortada";
L.CUT_MAIL_BODY = "Desenvolvido por Gargul: uma ferramenta Master Loot com suporte para TMB, SoftRes, GDKP e Auto-Looting!";
L.CUT_MAIL_EVEN = "Você não deve ouro a %s";
L.CUT_MAIL_FAILED = "Falha ao enviar corte para %s";
L.CUT_MAIL_GOLD_MISMATCH = "Correio ENVIADO de acordo com o jogo, mas o OURO restante NÃO CORRESPONDE, algo deu errado?";
L.CUT_MAIL_HISTORY = "Histórico de e-mail para |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "Você não tem ouro suficiente para pagar %s";
L.CUT_MAIL_IN_PROGRESS = "Espere um pouco, ainda estamos processando o e-mail anterior";
L.CUT_MAIL_SUBJECT = "Gargul GDKP: %sg";
L.CUT_SENT = "Enviou %sg para %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Excluir";
L.DETAILS = "Detalhes";
L.DFT = "DFT";
L.DISABLE = "Desativar";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Desencantar";
L.EDIT = "Editar";
L.ENABLE = "Habilitar";
L.EXPORT = "Exportar";
L.EXPORT_DELETE_ALL_CONFIRM = "Tem certeza de que deseja remover toda a tabela do histórico de recompensas? Isso exclui TODOS os dados de saque e não pode ser desfeito!";
L.EXPORT_DELETE_DATE_CONFIRM = "Tem certeza de que deseja remover todos os dados de %s? Isto não pode ser desfeito!";
L.EXPORT_READ_ONLY_NOTICE = [[
Este é APENAS um recurso de exportação, não faz sentido editar nenhum dos valores: ELES NÃO SERÃO SALVOS!

]];
L.FILL = "Preencher";
L.FINAL_CALL = "Última chamada";
L.FINISH = "Terminar";
L.FORMAT = "Formatar";
L.GARGUL = "Gárgula";
L.GDKP = "RGPD";
L.GDKPS_ARE_NOT_ALLOWED = "Os ataques GDKP não são permitidos nesta versão do World of Warcraft";
L.GDKP_ACTIVATED = "GDKP ativo!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Adicionar itens descartados à fila";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Ouro (- para remover ouro)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Quem paga por isso?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "O ouro precisa ser menor/maior que 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Pago por";
L.GDKP_ADD_GOLD_TITLE = "Ajuste o ouro em %s";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Você não pode dar E receber ouro do mesmo jogador ao mesmo tempo";
L.GDKP_ALL_CUTS_MAILED = "Todos os cortes foram enviados!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Desativar para desencantado";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Desativar em combate";
L.GDKP_AUCTIONS = "Leilões";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Criado por";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Excluído por %s
Razão: %s]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg adicionado ao pote por %s
Notas]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s pagou |c00%s%sg por
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Venceu por";
L.GDKP_AUCTION_PAID_AMOUNT = "Definir valor pago (leia à esquerda)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul monitora automaticamente o ouro negociado. Contanto que os jogadores paguem
pelo que eles compraram, você nunca deveria precisar deste campo

'Valor pago' refere-se à quantidade de ouro que o comprador já negociou com você.
Isso não altera o preço real do item!

Atenção: só defina um valor aqui se o jogador prometer pagar
fora do ataque ou negocia o ouro de um alt/mail etc!


]];
L.GDKP_AWARD_DIALOG_LABEL = "Preço do PIB:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Conceder %s a %s por %s?";
L.GDKP_BIDDER_AUTO_BID = "Lance automático";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Qual é o seu lance máximo? (Mínimo %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Lance negado!";
L.GDKP_BIDDER_ITEM_PRICING = "Lance mínimo: %sg Incremento: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(máximo %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Novo lance";
L.GDKP_BIDDER_STOP_AUTO_BID = "Interromper lance automático";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Lance máximo: %s por %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Lance máximo: %s seu";
L.GDKP_CREATE = "Crie uma nova sessão do GDKP";
L.GDKP_CREATE_MANAGEMENT_CUT = "% de corte de gerenciamento";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut precisa estar vazio ou entre 0 e 99 (sem sinal de %!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Escolha um tipo de sessão!";
L.GDKP_CREATE_SESSION_SWITCH = "Mudar para esta sessão";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFO Multi-Leilão permite que você inicie lances em vários itens de uma vez, acelerando as coisas!
Siga as instruções após criar esta sessão para começar

Com |c00A79EFFSleilão Único você escolhe leiloar itens únicos ou usar a fila

Selecionar |c00A79EFFMulti-Auction evita que itens descartados sejam adicionados à fila
Você pode misturar |c00A79EFFMulti-Auction com |c00A79EFFSingle-Auction e a fila, mas desaconselhamos fortemente isso

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Tipo de leilão (|c00A79EFFi para mais informações)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Leilão múltiplo";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Leilão Único";
L.GDKP_CREATE_SUCCESSFUL = "Sessão criada. Aconselhamos você a usar /reload para que ele seja armazenado corretamente caso seu jogo trave!";
L.GDKP_CUTS_ADD_RAIDER = "Adicionar Invasor";
L.GDKP_CUTS_ADJUST_G = "ajustar [g]";
L.GDKP_CUTS_ADJUST_P = "ajustar [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Anuncie o corte básico no chat em grupo";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Tem certeza de que deseja redefinir todos os jogadores e cálculos? Nota: todos os jogadores que não estiverem mais na raid serão removidos da lista!";
L.GDKP_CUTS_DELETE_RAIDER = "Excluir invasor";
L.GDKP_CUTS_EDIT_RAIDER = "Editar invasor";
L.GDKP_CUTS_LOCK_TOOLTIP = "Bloquear e Pagar";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Gerenciar negociações de ouro";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Com mutadores você pode dar mais ou menos ouro aos jogadores
Exemplo: dar 2% a mais aos tanques é para que servem os mutadores!

Nota: Editar ou excluir modificadores aqui apenas os altera para esta sessão

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Não no ataque";
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
L.GDKP_CUTS_SUMMARY = "%s Invasores | %s Com corte | Pagamento total: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "Nada para importar, verifique seu CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Faltando ouro para o jogador %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Cabeçalho ausente, observação: diferencia maiúsculas de minúsculas!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Nome do jogador ausente";
L.GDKP_DELETE_BID_INFO = "Excluir lance. O leilão deve ser interrompido primeiro!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Adicione um raider a esta sessão";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Personalizado (crie seu próprio formato)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Detalhado (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Compartilhar (pode ser importado por outros jogadores)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Seu formato personalizado";
L.GDKP_EXPORT_CUSTOM_HEADER = "Seu cabeçalho personalizado";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Personalizado (crie seu próprio formato)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@JOGADOR,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Jogador, Corte";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "data/hora em que a sessão foi bloqueada";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "ouro total dado ao jogador";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "ouro enviado ao jogador";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "total de ouro recebido do jogador";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "data/hora em que o primeiro item foi concedido";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "ouro negociado com o jogador";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Item, Jogador, Ouro, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Data/hora em que o primeiro item foi concedido";
L.GDKP_EXPORT_FORMAT_TITLE = "O título da sessão GDKP";
L.GDKP_EXPORT_POT_CHANGED = "Pote alterado";
L.GDKP_GOLD_TRADES = "Negociações de Ouro";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Tem certeza? Você não poderá ver ou dar lances em itens futuros!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! AVISO!!|r

Você está em um reino conectado e está importando nomes de jogadores sem
um sufixo de domínio, '%s' por exemplo. Isso pode fazer com que você envie
corta e corta e-mails para o jogador errado.

Quando estiver em um reino conectado, sempre tente incluir o nome do reino dos jogadores!

Continuar importando?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Isso substituirá todas as alterações feitas na janela de corte, tem certeza?";
L.GDKP_IMPORT_CUTS_INFO = [[
Você pode importar cortes de jogadores de seus próprios cálculos, como uma planilha do Google. softwares GDKP etc.

O formato é o seguinte (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Jogador,Ouro|c00967FD2
Jogador1.4000
Jogador2,4125
Jogador3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Importe preços mínimos e incrementos do GDKP.

O formato é o seguinte: ItemID + mínimo ou incremento são obrigatórios. (|c00BE3333REQUER UM CABEÇALHO!!):

|c00BE3333ItemID,Mínimo,Incremento|c00967FD2
18608.4000.500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Excluir configurações de preço existentes? Clique em sim para excluir todos os dados de preços e em não para simplesmente substituir os existentes pelos dados fornecidos aqui";
L.GDKP_IMPORT_SESSION = "Importar sessão do GDKP";
L.GDKP_IMPORT_SESSION_ABOUT = "Aqui você pode importar (e continuar) uma sessão do GDKP. Para obter uma sessão GDKP de alguém, ele precisa exportá-la para |c00FFF569/gdkp, onde seleciona o formato 'Compartilhar (pode ser importado por outros jogadores)'";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Você está prestes a importar uma sessão do GDKP criada por %s, tem certeza?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Esta sessão do GDKP criada por %s parece já existir. Deseja substituí-la?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Dados inválidos fornecidos para extensão GDKP!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Dados inválidos fornecidos para reagendamento do GDKP!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Dados inválidos fornecidos para redução do GDKP!";
L.GDKP_INVALID_DATA_FOR_START = "Dados inválidos fornecidos para início do leilão GDKP!";
L.GDKP_INVALID_PAID_AMOUNT = "Número inválido fornecido para 'pago'";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Tempo inválido fornecido no leilão: reprogramar";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Dados (vendidos %sx)
Última venda por: %s
Preço médio: %s
Lance mínimo: %s
Incremento: %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Saldo: |c0092FF000 ? Você é quadrado! | |c00BE333330? você deve %s 30g | |c00F7922E50? %s lhe deve 50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Ouro enviado para você por %s";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Ouro pago a %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Ouro recebido de %s";
L.GDKP_LEDGER_MUTATION = "Ouro %s por"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Pote total: %sg | Corte de gestão: %sg (%s%%) | Para distribuir: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Por %s%s | Em |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "A sessão do GDKP não está disponível ou bloqueada";
L.GDKP_MAIL_ALL = "Enviar tudo";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Nenhum lance no item Legendary+ detectado, continue manualmente!";
L.GDKP_MISSING_CONTENT_FOR_START = "Conteúdo ausente no leilão: início";
L.GDKP_MULTIAUCTION_ABOUT = [[

Com leilões múltiplos (ou leilões em lote), você pode leiloar quantos itens quiser de uma só vez!
Isso acelera imensamente suas noites de ataque e proporciona uma experiência perfeita para seus invasores

Todos os itens negociáveis ​​ainda em seu inventário podem ser leiloados automaticamente com 'Preencher do inventário'
Experimente!

|c00808080Há apenas uma desvantagem: para que as pessoas participem de um leilão em lote, os invasores precisarão de Gargul!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Você precisa ter uma sessão GDKP ativa (desbloqueada)!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Com esta janela aberta, %s itens para adicioná-los à lista ou clique em 'Preencher do inventário' abaixo"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti-snipe em segundos";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "O valor anti-snipe precisa ser 0 (vazio) ou >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Volte para o seletor de itens";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Remover todos os itens da lista";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Preencher do inventário";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Adicione itens negociáveis ​​do seu inventário à lista";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Aqui você determina quais itens incluir em sua sessão de leilões múltiplos

Use o botão |c00A79EFFFFill from inventário abaixo para adicionar itens que ainda podem ser negociados à lista
Sempre que você limpar e reabrir esta janela, suas últimas configurações de preenchimento serão usadas para adicionar itens automaticamente

|c00A79EFF%s itens para adicioná-los manualmente à lista
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Próxima etapa: verifique a compatibilidade da versão do complemento do raider";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Nem todo mundo usa Gargul. Tem certeza de que deseja iniciar o leilão?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Selecione pelo menos um item para o seu leilão";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Seu Gargul está desatualizado, recomendamos atualizá-lo antes de iniciar uma sessão para evitar problemas!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Nem todo mundo está atualizado. Se você estiver enfrentando problemas, diga aos seus invasores para atualizarem!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Há um leilão múltiplo ativo, os itens que você adicionar aqui serão adicionados à sessão existente. Esteja atento a itens duplicados!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Nome de pesquisa ou iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Suporta nomes de itens e iLVL, por ex. '252', '<252' etc.";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Sessão ativa do GDKP: |c00967FD2%s | Por %s%s | Em |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Tempo do leilão em segundos";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "O tempo do leilão em segundos precisa ser >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Você saiu durante a sessão de lances do GDKP. Para retomá-lo, você deve fornecer um novo tempo de lance (em segundos) para quaisquer itens não vendidos";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Com esta janela aberta, %s itens para adicioná-los à lista";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Clique no ícone da roda dentada para gerenciar um leilão";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Você já é o maior licitante em %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Lance |c00%s%sg
Por %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sFECHADO
Sem lances]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Mínimo: |c00%s%sg
Incremento: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Itens: %s - Total vendido: %sg - prometido por mim: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Itens com lances: %s/%s
Total vendido: %s
Comprado por mim: %s
Lance total (não inclui vendas): %s
Lance meu (não inclui vendido): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sVENDIDO para
%s para |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Lance |c00%s%sg
Por |c0092FF00VOCÊ!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Não foi possível interromper o lance automático em %s. Tente novamente ou /recarregue!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Lance automático até um máximo de %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Lance automático até o lance que você preencheu à esquerda";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Interrompa seu lance automático (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "Não foi possível confirmar o lance de %s";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Lance inválido ou lance muito baixo! O mínimo é %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Você precisa esperar dois segundos entre lances no mesmo item";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Limpar lances";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Remover todos os lances do leilão";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Feche tudo";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "Fechar TODOS os leilões?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Fechar TODOS os leilões

Leilões com lances ativos serão vendidos e não poderão receber novos lances!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Fechar leilão";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Feche o leilão. Os jogadores não podem mais dar lances, mas o lance mais alto permanece ativo";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Remova o item do leilão, incluindo os detalhes do lance. ISSO NÃO PODE SER DESFEITO!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Desencantar todos os itens acabados, mas não vendidos?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Desencantar itens não vendidos

Isso marcará todos os itens não vendidos como desencantados e eles não aparecerão em uma nova sessão de leilão múltiplo
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favorite este item";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Dê um cronômetro de chamada final de quantos segundos?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "A quantidade mínima de segundos é 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Inicie uma chamada final para este leilão fornecendo um cronômetro de lance (geralmente mais curto)";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "Fechar TODOS os leilões e encerrar esta sessão de leilões múltiplos?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Concluir sessão de leilão múltiplo

Isto fechará todos os leilões e anunciará o pote total no chat
Leilões com lances ativos serão vendidos e não poderão receber novos lances!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Ocultar inativo";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Ocultar inutilizável";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Mostrar/Ocultar leilões finalizados";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Gerenciar leilão";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Lance o valor mínimo exigido";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Janela de lances fechada, use |c00A79EFF/gl bid para reabri-la!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Anuncie vendas no chat";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Reproduzir som quando o lance for superado";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Mais opções de som...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Mostre tudo";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Mostrar favoritos";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Mostrar inativo";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Mostrar inutilizável";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Este item foi vendido. Use o razão (|c00%s/gdkp) para fazer alterações!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Encerrar";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Remover todos os lances e fechar todos os leilões?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Encerrar sessão de leilão múltiplo

Isso excluirá todos os lances de itens que ainda não foram vendidos e fechará todos os leilões!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Passe o mouse sobre qualquer um dos botões abaixo para obter mais informações";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Mostrar/ocultar itens que você não pode usar";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Dados inválidos fornecidos para início do leilão GDKP!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s comprou %s por %sg";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "O loot master (%s) está desatualizado, isso pode fazer com que os lances falhem!";
L.GDKP_MULTIAUCTION_OUTBID = "Você foi superado!";
L.GDKP_MUTATORS = "Mutadores";
L.GDKP_MUTATOR_ADD = "Adicionar mutador";
L.GDKP_MUTATOR_APPLY_LABEL = "Aplicar automaticamente a";
L.GDKP_MUTATOR_CREATE_NEW = "Crie um novo modificador GDKP";
L.GDKP_MUTATOR_DELETE_BYPASS = "Excluir. Segure shift para ignorar a confirmação";
L.GDKP_MUTATOR_EDIT = "Editar modificador";
L.GDKP_MUTATOR_FLAT_LABEL = "Taxa fixa de ouro [exemplo: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "A taxa fixa precisa ser um número";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Exemplo:
|c00967FD2SELF,RL,CURADOR]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Você pode aplicar este modificador automaticamente aos invasores usando palavras-chave:";
L.GDKP_MUTATOR_NAME_LABEL = "Nome [exemplo: Tanques]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Os nomes dos mutadores não podem conter pontos (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Porcentagem [exemplo: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "A porcentagem precisa ser um número";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Armazenar para sessões futuras";
L.GDKP_MUTATOR_UNKNOWN = "Mutador desconhecido: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "O usuário '%s' não tem permissão para iniciar leilões";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "O usuário '%s' não tem permissão para interromper leilões";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "O usuário '%s' não tem permissão para interromper o leilão: leilão inválido";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Não há ouro suficiente para distribuir, espere alguns cálculos estranhos de corte!";
L.GDKP_NO_BIDS = "Sem lances!";
L.GDKP_OUTBID = "Você foi superado!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(ativo)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Você precisa de chumbo ou saque mestre para ajustar o ouro.
Você não pode ajustar o ouro em sessões bloqueadas/excluídas]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Adicionar/remover ouro";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s pagou |c00%s%s por
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Excluído por %s
Razão: %s]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(excluído)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Você precisa de saque principal ou mestre para excluir entradas.
Você não pode excluir entradas em sessões bloqueadas/excluídas]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Forneça um motivo para excluir esta entrada";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Excluir. Segure shift para ignorar a nota";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Sessões com leilões anexados serão excluídas após 48 horas";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Você precisa de saque principal ou mestre para editar entradas.
Você não pode editar entradas excluídas ou entradas em sessões bloqueadas/excluídas]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Exporte uma sessão para que outras pessoas possam ver os detalhes da sessão ou até mesmo substituí-lo como mestre de saque";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importe uma sessão de outro jogador ou conta";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Mostrar uma visão geral completa do razão,
ideal para fins de captura de tela!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Bloquear uma sessão significa que você não pode leiloar itens ou alterar nada até desbloqueá-la, tem certeza?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Bloquear ou desbloquear a sessão";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Bloqueie a sessão para pagamento";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Leilão múltiplo: leiloe vários itens de uma vez!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "Adicionado a";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s pote por %s
Notas]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "removido de";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Pote: %s
Corte gerencial (%s%%): %sg
Corte por jogador (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Você precisa de saque principal ou mestre para restaurar as entradas.
Você não pode restaurar entradas de sessões bloqueadas/excluídas]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Por %s%s | Em |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Desbloquear e alterar o pote ou cortes pode ser muito complicado, especialmente se você já tiver feito pagamentos. Tem certeza?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Desbloquear a sessão";
L.GDKP_PAYOUT_INACTIVE = "Nenhuma sessão ativa do GDKP detectada ou a sessão não está bloqueada para pagamento!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "O incremento ou mínimo não pode ser inferior a 0,0001!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "'Incremento' inválido fornecido para o ID do item '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "'Mínimo' inválido fornecido para o ID do item '%s'";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "É necessário um mínimo ou incremento para o ID do item: %s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Cabeçalho ausente, observação: diferencia maiúsculas de minúsculas!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Dados importados com sucesso para %s itens";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "ID de item desconhecido: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s itens em bolsas, janelas de saque ou até mesmo em links no seu chat para adicioná-los a esta fila de leilão.
Os itens na fila serão leiloados automaticamente assim que o leilão atual for concluído. Clique no botão '%s' para evitar isso.

Quer que Gargul premie ou desencante leilões automaticamente para você? Abra a roda de configurações no lado esquerdo!

|c00FFF569Você sabia?
Você pode mover itens arrastando e soltando
Os itens serão lembrados, mesmo quando você |c00A79EFF/recarregar
Os itens na fila são mostrados automaticamente aos invasores que possuem Gargul para que possam pré-oferecer
Gargul também pode cuidar do saque automático para você. Confira com |c00A79EFF/gl pm
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Ocultar itens inutilizáveis";
L.GDKP_SESSION = "Sessão GDKP";
L.GDKP_SESSION_EDIT_TITLE = "Editando %s";
L.GDKP_SHOW_UPCOMING = "Mostrar próximos itens";
L.GDKP_STOP_AUCTION_FIRST = "Pare o leilão primeiro!";
L.GDKP_THEY_OWE = "%s lhe deve %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Sessão
Gasto pelo jogador: %s
Dado: %s
Recebido: %s
Corte de jogador: %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Excluir do GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "O ouro negociado não será adicionado ao valor dado ou recebido";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Ouro |c00967FD2dado a %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Não foi possível adicionar %s à janela de negociação. Tente adicioná-lo manualmente!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "Você não tem dinheiro suficiente para pagar %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "Para dar: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Para receber: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Ouro |c00967FD2recebido de %s";
L.GDKP_TRY_MULTIAUCTION = "Confira Multi Leilões!";
L.GDKP_TUTORIAL_INFO = "Siga as etapas abaixo para começar rapidamente a usar o Gargul GDKP!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Ative esta sessão clicando no botão |c00FFF569Enable abaixo!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s um item para leiloar ou colocar um único item na fila"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Comandos úteis:
- |c00FFF569/gdkp para abrir esta janela
- |c00FFF569/gl ma para abrir a janela de leilões múltiplos
- |c00FFF569/gl au para abrir o leiloeiro/fila de item único
- |c00FFF569/gl pm para configurar o saque automático

]];
L.GDKP_TUTORIAL_STEP_DONE = "Se tudo correr bem, você verá seus itens recentemente leiloados aqui!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Quer leiloar vários itens de uma vez? Execute |c00FFF569/gl ma (ou |c00FFF569/gl multiauction) ou clique no ícone de multi-leilão no canto superior direito desta janela!";
L.GDKP_TUTORIAL_STEP_NEW = "Clique no botão |c00FFF569Novo abaixo para criar sua primeira sessão GDKP. Ele será exibido à esquerda quando criado";
L.GDKP_TUTORIAL_STEP_READY = "Você está pronto para vender itens! |c00BE3333Leia todas as etapas abaixo com atenção e teste-as você mesmo (não há necessidade de participar de uma invasão) antes de iniciar sua primeira invasão do GDKP!";
L.GDKP_TUTORIAL_STEP_SELL = "Quer vender um item sem ninguém licitar? |c00FFF569%s em um item, escolha um vencedor e defina um preço!";
L.GDKP_TUTORIAL_TITLE = "Começando";
L.GDKP_UNKNOWN_ITEM = "ID do item desconhecido no leilão:create: %s";
L.GDKP_UNKNOWN_SESSION = "SessionIdentifier desconhecido no leilão:create: %s";
L.GDKP_YOU_OWE = "Você deve %s %s";
L.GIVEN = "Dado";
L.GOLD_INDICATOR = "g";
L.GROUP = "Grupo";
L.GROUP_MANAGER = "Gerente de grupo";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Baixe no CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Parar";
L.HEADER = "Cabeçalho";
L.HELLO = "|c00%sGargul v%s por Zhorax@Firemaw. Digite |c00%s/gl ou |c00%s/gargul para começar!";
L.HIDE = "Esconder";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "Visite o URL abaixo para saber mais sobre como personalizar Gargul GDKPs";
L.IDENTITY_TOOLTIP = "Seu logotipo aqui? Clique para mais informações!";
L.IMPORT = "Importar";
L.IMPORTED_AND_UPDATED_ON = "Importado em |c00A79EFF%s em |c00A79EFF%s, atualizado em |c00A79EFF%s em |c00A79EFF%s";
L.IMPORT_EXPLANATION = "Que tipo de dados você gostaria de importar?";
L.IMPORT_SUCCESSFUL = "Importação de dados de rolagem otimizada bem-sucedida";
L.INC = "Inc.";
L.INCLUDE_AWARDED = "Incluir itens premiados anteriormente";
L.INCLUDE_BOES = "Incluir BOEs";
L.INCLUDE_MATERIALS = "Inclui materiais (como Cristais do Abismo)";
L.INCREMENT = "Incremento";
L.INFO = "Informações";
L.INVALID_DATA_WARNING = "Dados inválidos fornecidos";
L.ITEM = "Item";
L.JSON_DECODE_WARNING = "Não é possível decodificar dados JSON. Certifique-se de copiar/colar como está, sem adicionar caracteres adicionais ou espaços em branco!";
L.KEYS_INFO = [[
Teclas de atalho de item Gargul

Implementação: |c00A79EFF%s
Prêmio: |c00A79EFF%s
Desencantar: |c00A79EFF%s


-- Clique com o botão direito para desativar esta janela --
]];
L.LEDGER = "Razão";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "Você precisa ser o mestre saqueador ou ter um papel de auxiliar/liderança!";
L.LOCALE_CHANGE_NOTE = "Nota: você pode alterar o local a qualquer momento nas configurações ou via |c00%s/gl locale";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul posta mensagens de bate-papo em inglês (padrão)
Você pode selecionar um idioma diferente no menu suspenso abaixo

Seu idioma de bate-papo atual é '%s'. A ativação de um idioma diferente causará um /reload!
]];
L.LOCALE_NONE_TITLE = "Escolha um idioma de bate-papo para Gargul";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Você tem um ou mais complementos instalados que podem causar mau funcionamento do Gargul: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Limpar SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Limpar TMB";
L.LOOTMASTER_DEFAULT_NOTE = "/roll para MS ou /roll 99 para sistema operacional";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Importar SoftRes";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Importar TMB";
L.LOOTMASTER_NOTICE_LABEL = "Você recebeu o papel de Mestre Looter";
L.LOOTMASTER_OPEN_LABEL = "Abra esta janela automaticamente";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Prioridades de saque eliminadas com sucesso";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Forneça um CSV prio no seguinte formato (1 linha por item): id ou nome > prio1, equalprio > prio2 > etc.";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Prioridades de saque importadas com sucesso";
L.LOOTPRIORITY_INVALID_DATA = "Dados inválidos fornecidos";
L.LOOTPRIORITY_INVALID_LINE = "Dados inválidos fornecidos na linha: '%s': ID ou prioridade do item ausente";
L.LOOTPRIORITY_PROCESS_INCOMING = "Tentando processar prioridades de saque recebidas de %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Saque Prio";
L.MAIL = "Correspondência";
L.MAILED = "Enviou";
L.MAIL_CUTS_EXPLANATION = "Correio cortado para jogadores";
L.MAINSPEC_ABBR = "EM";
L.MAXIMIZE = "Maximizar";
L.MIN = "Mínimo";
L.MINIMAP_BUTTON_AWARDED = "Histórico de saques premiados";
L.MINIMAP_BUTTON_CUTS = "Cortes do GDKP";
L.MINIMAP_BUTTON_EXPORT = "Exportar dados";
L.MINIMAP_BUTTON_GARGUL = "Abrir Gárgula";
L.MINIMAP_BUTTON_IMPORT = "Importar dados";
L.MINIMAP_BUTTON_LEDGER = "Razão GDKP";
L.MINIMAP_BUTTON_MULTIAUCTION = "Multileilão";
L.MINIMAP_BUTTON_SETTING_INFO = "Alterar configurações no minimapa /gl";
L.MINIMIZE = "Minimizar";
L.MINIMIZE_ON_AWARD = "Minimizar o prêmio";
L.MINIMIZE_ON_START = "Minimizar no início";
L.MINIMUM = "Mínimo";
L.MINIMUM_QUALITY = "Qualidade Mínima";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Mover";
L.MULTI_AUCTION = "Leilão múltiplo";
L.NAME = "Nome";
L.NEW = "Novo";
L.NEXT = "Próximo";
L.NO = "Não";
L.NONE = "Nenhum";
L.NOTE = "Observação";
L.NOTHING = "Nada";
L.NO_BIDS_ACTION = "Quando ninguém dá lances, faça:";
L.NO_OFFICER_PRIVILEGES = "Você não tem privilégios de oficial";
L.OFFSPEC_ABBR = "SO";
L.OK = "OK";
L.OPEN = "Abrir";
L.OPEN_AUCTIONEER = "Leiloeiro aberto";
L.OPEN_MULTI_AUCTION = "Abrir multi-leilão";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "Definir %s como seu desencantador?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Enviar %s para %s? Digite /gl cd para remover esse desencantador!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "Nenhum conjunto de desencantador, use /gl sd [mydisenchanter] para definir um";
L.PACKMULE_WHO_IS_DISENCHANTER = "Quem é o seu desencantador?";
L.PAID = "Pago";
L.PASS = "Passar";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Jogador";
L.PLAYER_ITEM_WON_COUNT = "Itens ganhos por %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "Mais uns";
L.PLUSONES_AWARD_DIALOG_LABEL = "Adicionar um +1";
L.PLUSONES_BROADCAST_CONFIRM = "Tem certeza de que deseja transmitir seus dados de acompanhante para todos em seu grupo/raid?";
L.PLUSONES_BROADCAST_PROCESS_START = "Tentando processar dados recebidos de PlusOnes de %s";
L.PLUSONES_CLEAR_CONFIRM = "%s deseja limpar todos os seus dados do PlusOne. Limpar todos os dados?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Tem certeza de que deseja limpar os dados existentes do PlusOne e importar novos dados transmitidos por %s?";
L.PLUSONES_IMPORT_CONFIRM = "Tem certeza de que deseja importar novos dados transmitidos por %s?";
L.PLUSONES_IMPORT_ERROR = "Dados inválidos fornecidos. Certifique-se de que o conteúdo siga o formato exigido e que nenhuma linha de cabeçalho esteja incluída";
L.PLUSONES_IMPORT_INFO = [[
Aqui você pode importar mais um dado de uma tabela em formato CSV ou TSV ou colado de uma planilha do Google Docs.

A tabela precisa de pelo menos duas colunas: O nome do jogador seguido da quantidade de pontos. Colunas adicionais são ignoradas.

Aqui está um exemplo de linha:

Foobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Aceitar automaticamente transmissões recebidas de %s";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Bloquear todos os dados compartilhados +1 recebidos";
L.PLUSONES_UPDATE_CONFIRM = [[
Tem certeza de que deseja atualizar seus dados existentes do PlusOne com dados de %s?

Sua atualização mais recente foi em |c00A79EFF%s, a deles em |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!mais um|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Panela";
L.PRICE = "Preço";
L.PRIOLIST_ABBR = "PT";
L.QUALITY_COMMON = "Comum";
L.QUALITY_EPIC = "Épico";
L.QUALITY_HEIRLOOM = "Herança";
L.QUALITY_LEGENDARY = "Lendário";
L.QUALITY_POOR = "Pobre";
L.QUALITY_RARE = "Cru";
L.QUALITY_UNCOMMON = "Incomum";
L.QUEUE = "Fila";
L.RAIDERS = "Invasores";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Quem está faltando";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Mostrar nomes de jogadores ausentes";
L.RAIDGROUPS_DISBAND_BUTTON = "Dissolver ataque";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Dissolva seu ataque";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s está listado duas vezes na lista!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "uma exportação |c00FFF569Raid-Helper (use a variante 'Grupos classificados verticalmente') ou um CSV de composição de grupo |c00FFF569Gargul:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
Na grande caixa de edição abaixo você pode fornecer uma lista e: convidar todos, verificar quem está faltando, inscrever grupos e atribuir os tanques.

Você pode fornecer um link de composição de raid |c00FFF569Wowhead:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki do Grupo Gargul";
L.RAIDGROUPS_GARGUL_INFO = "Visite o wiki do grupo Gargul para obter mais informações sobre o formato do grupo raid.";
L.RAIDGROUPS_IMPOSTER_WARNING = "Os seguintes jogadores não fazem parte da escalação: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Dados de grupo inválidos fornecidos. Verifique seu formato!";
L.RAIDGROUPS_INVITE_BUTTON = "Convidar";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Envie convites para jogadores na escalação";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Não é possível ordenar grupos enquanto %s está em combate!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "Você precisa estar em um ataque!";
L.RAIDGROUPS_NO_TANKS_WARNING = "Nenhum tanque definido";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Não consegue encontrar um lugar para %s. Você está tentando colocar mais de 5 pessoas em um grupo?";
L.RAIDGROUPS_PURGE_BUTTON = "Expulsar jogadores indesejados";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Expulsar jogadores que não estão no elenco";
L.RAIDGROUPS_SORTING_ERROR = "Algo deu errado ao mover %s";
L.RAIDGROUPS_SORTING_FINISHED = "Concluída a aplicação da escalação da raid";
L.RAIDGROUPS_SORTING_GROUPS = "Classificando grupos";
L.RAIDGROUPS_SORT_BUTTON = "Aplicar grupos";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Classifique os grupos com base na lista";
L.RAIDGROUPS_SORT_IN_PROGRESS = "A classificação ainda está em andamento, espere um pouco!";
L.RAIDGROUPS_TANKS_ASSIGNED = "Todos os tanques são atribuídos";
L.RAIDGROUPS_TANK_BUTTON = "Atribuir tanques";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Ferramenta Wowhead Comp";
L.RAIDGROUPS_WOWHEAD_INFO = "Você pode visitar a ferramenta wowhead comp usando o URL abaixo. Depois de criar sua composição você pode colá-la aqui ou no grande campo de edição da janela do grupo Gargul";
L.REMOVE_BID = "Remover lance";
L.RESET_SETTINGS = "Redefinir as configurações";
L.RESET_SETTINGS_CONFIRMATION = "Tem certeza de que deseja redefinir todas as configurações do Gargul? Isso não pode ser desfeito!";
L.RESET_UI = "Redefinir interface do Gargul";
L.RESET_UI_CONFIRMATION = "Tem certeza de que deseja redefinir todos os tamanhos, posições e escala das janelas do Gargul? Isso não pode ser desfeito!";
L.RESTORE = "Restaurar";
L.RESUME = "Retomar";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Rolar";
L.ROLLING_AWARD_CONFIRM = "Premiar %s para %s?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Fechar no prêmio";
L.ROLLING_CLOSE_ON_START_LABEL = "Fechar no início";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Segure shift para ignorar a confirmação do prêmio";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Segure shift para mostrar a confirmação do prêmio";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Atenção: foi encontrado outro lançamento idêntico que pode apontar para um empate

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Dados inválidos fornecidos para lançamento inicial!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(item fornecido: sim)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(item dado: não)";
L.ROLLING_ITEM_WON_OS = "(SO)";
L.ROLLING_NOTE_LABEL = "OBSERVAÇÃO";
L.ROLLING_NO_ROLLOFF_WARNING = "Não consigo parar de rolar, não há rolagem em andamento";
L.ROLLING_PASS_BUTTON = "Passar";
L.ROLLING_REOPEN_ROLL_COUNT = "rolos: %s";
L.ROLLING_REOPEN_TOOLTIP = "Abrir janela mestre do saqueador";
L.ROLLING_ROLL_ACCEPTED = "Rolo aceito!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Uma rolagem está em andamento";
L.ROLLING_ROLL_PRIOLIST = "Prévio [%s]";
L.ROLLING_ROLL_SR_COUNT = "RS [%sx]";
L.ROLLING_ROLL_WISHLIST = "Desejo [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Você precisa selecionar um jogador primeiro";
L.ROLLING_TIMER_LABEL = "TEMPORIZADOR(es)";
L.ROLLING_UNUSABLE_ITEM = "Você não pode usar este item!";
L.ROLLING_WINNER_NOT_UNIQUE = "O nome do vencedor não é único, selecione o jogador ao qual você gostaria de premiar %s";
L.SECONDS_ABBR = "é";
L.SELECT_ALL = "Selecionar/Desativar tudo";
L.SESSION = "Sessão";
L.SETTINGS = "Configurações";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Anuncie lances recebidos";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Anuncie o pote após conceder o item";
L.SETTINGS_ANNOUNCE_START = "Anunciar o início do leilão";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Anuncie a contagem regressiva no aviso de ataque";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Anuncie lances recebidos em aviso de invasão";
L.SETTINGS_RESET_UI = "Redefinir interface do Gargul";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Sussurre o licitante se o lance for muito baixo";
L.SILVER_INDICATOR = "é";
L.SKIP = "Pular";
L.SOFTRES = "Reservas suaves";
L.SOFTRES_ABBR = "RS";
L.SOFTRES_BROADCAST_CONFIRM = "Tem certeza de que deseja transmitir seus dados de softres para todos em seu grupo/raid?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Não foi possível processar os dados SoftRes recebidos de %s";
L.SOFTRES_CLEAR_CONFIRM = "Tem certeza de que deseja limpar todos os dados de reserva temporária existentes?";
L.SOFTRES_EVERYONE_RESERVED = "Todos preencheram suas reservas suaves";
L.SOFTRES_FEATURE_MISSING = [[
As informações sobre reservas definitivas não estão disponíveis porque as reservas flexíveis
fornecidos não foram gerados usando o botão 'Gargul Export' em softres.it]];
L.SOFTRES_IMPORT_DETAILS = "Importado em |c00A79EFF%s em |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Correção automática de nome: o SR de '%s' agora está vinculado a '%s'";
L.SOFTRES_IMPORT_INFO = "Para começar, primeiro você precisa criar um ataque em softres.it. Em seguida clique em ‘Addon Export’, selecione ‘Gargul’, copie os dados e cole no formulário abaixo.";
L.SOFTRES_IMPORT_INVALID = "Dados de reserva temporária inválidos fornecidos";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Dados inválidos fornecidos. Certifique-se de clicar no botão 'Gargul Export' em softres.it e cole o conteúdo completo aqui";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Os valores PlusOne fornecidos colidem com os já presentes. Você deseja substituir seus antigos valores PlusOne?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Os seguintes jogadores não reservaram nada:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Reservas temporárias importadas com sucesso";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Importação bem sucedida!";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura e dados CSV estão obsoletos, use a exportação Gargul!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Falha ao conectar-se ao LootReserve, entre em contato com o suporte (inclua a mensagem abaixo)";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "Nenhum URL softres.it disponível, certifique-se de exportar usando o botão 'Gargul Export' em softres.it!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Clique aqui para ver informações sobre reservas definitivas";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Nenhum item é reservado";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Nenhuma informação de reserva física disponível";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Postar RSs ausentes";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "URL da postagem SR";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Este jogador não reservou nada!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Tentando processar dados SoftRes recebidos de %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Este item é reservado";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Para s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Nota: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Reservado por";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Algo deu errado!";
L.START = "Começar";
L.STOP = "Parar";
L.TAB_REPLACES_T = "	 is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Tempo";
L.TITLE = "Título";
L.TMBETC = "TMB, DFT ou PRIO3";
L.TMB_BROADCAST_CONFIRM = "Tem certeza de que deseja transmitir seus dados TMB para todos no seu grupo/raid? NB: TODOS podem ver seus dados do TMB, independentemente de suas permissões no site do TMB!";
L.TMB_BROADCAST_PROCESS_START = "Tentando processar dados TMB recebidos de %s";
L.TMB_CLEAR_CONFIRM = "Tem certeza de que deseja limpar todos os dados mais um?";
L.TMB_CLEAR_RAIDER_DATA = "Limpar dados do Raider";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "Limpar dados TMB para todos os invasores?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Compartilhamento automático ativado: %s";
L.TMB_IMPORT_CPO_INFO = "Na execução do classicpr.io, clique no botão 'Gargul Export' e copie o conteúdo. Depois cole o conteúdo como está na caixa abaixo e clique em 'Importar'. É isso!";
L.TMB_IMPORT_DETAILS = "Importado em ${date} às ${time}";
L.TMB_IMPORT_DFT_INFO = "Exporte seus dados DFT de acordo com as instruções da planilha. Depois cole o conteúdo como está na caixa abaixo e clique em 'Importar'. É isso!";
L.TMB_IMPORT_INVALID_CSV = "CSV inválido fornecido, o formato é: 6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "Dados DFT inválidos fornecidos. Exporte seus dados DFT de acordo com as instruções da planilha e cole o conteúdo aqui como está!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Dados TMB inválidos fornecidos, certifique-se de clicar no botão 'Download' na seção Gargul e colar o conteúdo aqui como está!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Dados TMB ou DFT inválidos fornecidos, certifique-se de colar o conteúdo de exportação aqui como está!";
L.TMB_IMPORT_NOTES_AVAILABLE = "Notas prioritárias disponíveis: %s";
L.TMB_IMPORT_NUMBER = "Número de itens importados: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "Os seguintes jogadores não têm %s entradas:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "Como usar Gargul com TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Cole o conteúdo de exportação do TMB como está na caixa abaixo e clique em 'Importar'";
L.TMB_NO_BROADCAST_TARGETS = "Não há ninguém no seu grupo para quem transmitir";
L.TMB_SYNCED = "Dados TMB sincronizados";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Nota: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(SO)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s Lista Prévia"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Camada: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "Lista de desejos TMB";
L.TOGGLE_DATES = "Mostrar/ocultar datas";
L.TOGGLE_QUEUE = "Mostrar/ocultar fila";
L.TRADETIME_AWARD_HOWTO = "%s para conceder itens!";
L.TRADETIME_ROLL_HOWTO = "%s para distribuir saques!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Ocultar todos os itens premiados";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Ocultar itens desencantados";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Ocultar itens concedidos a si mesmo";
L.TRADE_ANNOUNCE = "Anunciar negociação";
L.TRADE_ANNOUNCE_INFO = "Anuncie detalhes da negociação para o grupo ou em /say quando não estiver em um grupo";
L.TUTORIAL = "Tutorial";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s itens em bolsas, janelas de saque ou até mesmo em links no seu chat para adicioná-los à fila do leilão.
Quer vender um item diretamente sem licitar? Usar |c00A79EFF%s

Você pode abrir a janela %s diretamente digitando |c00A79EFF/gl leilão

Gargul rastreia |c00FF0000TODO ouro negociado. Não quer que uma negociação faça parte desta sessão do GDKP? Marque a caixa de seleção 'Excluir do GDKP' ao negociar!

|c00FFF569Você sabia?
Os itens premiados serão adicionados automaticamente à janela de negociação
Gargul também pode cuidar do saque automático para você. Confira com |c00A79EFF/gl pm
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
Esta janela mostra todos os itens que foram premiados em uma determinada data (selecione uma ou mais datas à esquerda).

Os itens podem conter as seguintes tags:

|c00A79EFFOS: Concedido por offspec
|c00A79EFFSR: Este item foi reservado de forma temporária
|c00A79EFFWL: Este item foi colocado na lista de desejos (Thatsmybis)
|c00A79EFFPL: Este item foi colocado na lista prio (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Os itens que você vê aqui estão na fila GDKP do saqueador mestre
Você pode removê-los, dar lances neles e ocultar itens inutilizáveis ​​(ative 'Ocultar itens inutilizáveis' nas configurações no canto superior esquerdo)

Você pode redimensionar a janela, movê-la ou minimizá-la. Experimente!

Para mestres de saque: remover itens aqui apenas os removerá da sua fila pessoal, não da fila real do GDKP!
]];
L.TUTORIAL_MORE_HELP = "Precisa de mais ajuda?";
L.TYPE = "Tipo"; -- As in type of roll or type of item
L.UNKNOWN = "desconhecido";
L.UNKNOWN_COMM_ACTION = "Ação de comunicação desconhecida '%s', certifique-se de atualizar o Gargul!";
L.UNLOCK = "Desbloquear";
L.UPDATE_GARGUL = "Atualize Gargul!";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Relatório";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Relate resultados desatualizados no bate-papo em grupo";
L.VERSION_CHECK_COLUMN_STATUS = "Status de gárgula";
L.VERSION_CHECK_STATUS_CHECKING = "Verificando versão...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: o player está atualizado
|c00F7922Ev%s: o jogador precisa atualizar seus add-ons
|c00BE3333%s: o player não tem Gargul ou está em uma versão não suportada
|c00808080%s: o jogador está offline ou nos ignorando!
|c0000FFFF%s: o jogador está na nossa lista de ignorados!

]];
L.VERSION_CHECK_STATUS_IGNORED = "JOGADOR IGNORADO!";
L.VERSION_CHECK_STATUS_OFFLINE = "desligada";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Sem resposta";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Sem resposta:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Desligada:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Desatualizado:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "Atualizado:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul está desatualizado e não funcionará até que você atualize!";
L.VERSION_INVALID_WARNING = "String de versão inválida fornecida em Version:addRelease";
L.VERSION_UPDATE = "Atualize Gargul!";
L.VERSION_UPDATED = "|c00%sGargul agora está atualizado para |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s está disponível em CurseForge/Wago. Você pode atualizar sem fechar o jogo, apenas certifique-se de /reload !";
L.WAIT_SECONDS_BEFORE_RETRY = "Aguarde mais %s segundos antes de tentar novamente";
L.WINDOW = "Janela";
L.WINDOW_HEADER = "Gárgula v%s";
L.WINDOW_SCALE = "Escala da janela";
L.WISHLIST_ABBR = "WL";
L.YES = "Sim";
L.YOU_DISABLED_GDKP_QUEUES = "Você desativou as filas do GDKP";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Não é possível compactar os dados com zlib. Contate o suporte via https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "Não foi possível descompactar os dados pelo zlib. Certifique-se de copiar/colar como está, sem adicionar caracteres adicionais ou espaços em branco!";
