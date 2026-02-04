--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "ptBR") then return; end
local L = Gargul_L or {};

L["About"] = "Sobre";
L["All Settings"] = "Todas as configurações";
L["Announce"] = "Anunciar";
L["Anti Snipe"] = "Anti-Snipe";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Um valor Anti Snipe de 10 significa que qualquer lance que venha com
menos de 10 segundos restantes redefinirá o cronômetro para 10 segundos

Você pode deixar em branco ou definir como 0 para desativar completamente o Anti Snipe.
Valores Anti Snipe inferiores a 5 não são suportados

]];
L["Are you sure?"] = "Tem certeza?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
Não se esqueça de usar Gargul
se você deseja exportar o saque mais tarde


-- Clique com o botão direito para desativar esta janela --]];
L["Auction"] = "Leilão";
L["Auctioneer"] = "Leiloeiro";
L["Auctions"] = "Leilões";
L["Auto"] = "Auto";
L["Auto award"] = "Recompensa automático";
L["Auto trade"] = "Comércio de automóveis";
L["Available values:"] = "Valores disponíveis:";
L["Award"] = "Recompensa";
L["Awarded To"] = "Concedido a";
L["BR: %s"] = "BR: %s";
L["Price: %s"] = "Preço: %s";
L["Given: yes"] = "Dado: sim";
L["Given: no"] = "Dado: não";
L["2nd bid: %s by %s"] = "2º lance: %s por %s";
L["You won"] = "Você ganhou";
L["Award %s to %s?"] = "Premiar %s para %s?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "Tem certeza de que deseja desencantar %s? %s pontos de rolagem aumentados serão reembolsados!";
L["In Group"] = "Em grupo";
L["Award history"] = "Histórco de prêmios";
L["Who should %s go to instead?"] = "Para quem %s deveria ir?";
L["Type player name here"] = "Digite o nome do jogador aqui";
L["or select one below"] = "ou selecione um abaixo";
L["Do you want to award %s to a random player?"] = "Quer premiar %s a um jogador aleatório?";
L["Drag and drop or shift+click an item in the box on the right"] = "Arraste e solte ou shift+clique em um item na caixa à direita";
L["(BR: %s)"] = "(BR: %s)";
L["Disenchanted items:"] = "Itens desencantados:";
L["(Given: yes)"] = "(Dado: sim)";
L["(Given: no)"] = "(Dado: não)";
L["(OS)"] = "(SO)";
L["%s boosted roll points will be refunded!"] = "%s pontos de rolagem aumentados serão reembolsados!";
L["Are you sure you want to undo %s awarded to %s?%s"] = "Tem certeza de que deseja desfazer %s concedidos a %s?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "Falha na inspeção da mochila: nenhum relatório foi recebido";
L["Inspection finished"] = "Inspeção concluída";
L["Starting inspection..."] = "Iniciando a inspeção...";
L["Balance"] = "Equilíbrio";
L["Base"] = "Base";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Não é possível decodificar dados em base64. Certifique-se de copiar/colar como está, sem adicionar caracteres adicionais ou espaços em branco!";
L["Bid"] = "Oferta";
L["Bids"] = "Lances";
L["BOE"] = "BOE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. Convidar/classificar automaticamente grupos a partir da inscrição no raid! Clique abaixo ou use |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. Recompense os jogadores por serem regulares ou por fazerem um esforço extra! Clique abaixo ou use |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul tem alguns truques na manga que você talvez não conheça. Dê uma olhada!";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul inclui mais um sistema de rastreamento! Clique abaixo ou use |c00A79EFF/gl po";
L["Boosted Rolls"] = "Rolagem Impulsionada";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
Adicione quantos pontos para todos que estão atualmente na raid?

|c00BE3333Use o botão 'Adicionar invasores ausentes' primeiro se quiser que todos ganhem pontos, mesmo aqueles sem uma entrada de rolagem aprimorada!]];
L["No point value provided!"] = "Nenhum valor de pontos fornecido!";
L["Add points to raid"] = "Adicione pontos ao ataque";
L["Add missing raiders"] = "Adicionar membros de raide ausentes";
L["Aliases"] = "Apelido";
L["Apply aliases"] = "Aplicar aliases";
L["Boosted Roll Cost:"] = "Custo de rolagem aumentado:";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "Tem certeza de que deseja transmitir seus dados de lançamento aprimorado para todos em seu grupo/raid?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "Nada para transmitir, importe primeiro os dados do Boosted Rolls!";
L["Couldn't process BoostedRolls data received from %s"] = "Não foi possível processar os dados do BoostedRolls recebidos de %s";
L["Attempting to process incoming BoostedRolls data from %s"] = "Tentando processar dados BoostedRolls recebidos de %s";
L["Are you sure you want to clear all boosted roll data?"] = "Tem certeza de que deseja limpar todos os dados de rolagem otimizada?";
L["Delete %s?"] = "Excluir %s?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "Tem certeza de que deseja limpar os dados existentes de rolagem otimizada e importar novos dados transmitidos por %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Dados inválidos fornecidos. Certifique-se de que o conteúdo siga o formato exigido e que nenhuma linha de cabeçalho esteja incluída";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
Aqui você pode importar dados e aliases de rolagem otimizados de uma tabela em formato CSV ou TSV ou colados de uma planilha do Google Docs.

A tabela precisa de pelo menos duas colunas: O nome do jogador seguido da quantidade de pontos. Colunas adicionais são opcionais e podem conter apelidos para o player.
Aqui está um exemplo de linha:

Foobar,240,Barfoo]];
L["Points"] = "Pontos";
L["Points: %s"] = "Pontos: %s";
L["N/A"] = "N/D";
L["Reserve"] = "reserva";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Tem certeza de que deseja atualizar suas listas otimizadas existentes com dados de %s?

Sua atualização mais recente foi em |c00A79EFF%s, a deles em |c00A79EFF%s.]];
L["!bonus|!rb|!br"] = "!bônus|!rb|!br";
L["Broadcast"] = "Transmissão";
L["Broadcasting..."] = "Transmissão...";
L["You are currently in combat, delaying broadcast"] = "Você está atualmente em combate, atrasando a transmissão";
L["Broadcast finished!"] = "Transmissão finalizada!";
L["Include awarded items"] = "Incluir itens premiados";
L["Include disenchanted items"] = "Incluir itens desencantados";
L["Include hidden items"] = "Incluir itens ocultos";
L["Include time left"] = "Incluir tempo restante";
L["Broadcast still in progress"] = "Transmissão ainda em andamento";
L["There is nothing to broadcast"] = "Não há nada para transmitir";
L["Number of items"] = "Número de ítens";
L["Broadcast ${percentage}%"] = "Transmissão ${percentage}%";
L["Target player (whisper only)"] = "Jogador alvo (apenas sussurro)";
L["Whisper requires a target player"] = "Whisper requer um jogador alvo";
L["Max trade time left (in minutes)"] = "Tempo máximo de negociação restante (em minutos)";
L["by"] = "por"; -- As in 'bid BY'
L["Cancel"] = "Cancelar";
L["Get support or share ideas on our Discord"] = "Obtenha suporte ou compartilhe ideias em nosso Discord";
L["Enable changelog"] = "Habilitar registro de alterações";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul torna a distribuição de itens muito fácil. Clique no botão abaixo para começar!";
L["Open Gargul"] = "Abrir Gárgula";
L["Adjust Scale"] = "Ajustar escala";
L["Channel"] = "Canal";
L["Officer"] = "Policial";
L["Raid Warning"] = "Aviso de invasão";
L["Whisper"] = "Sussurrar";
L["CPR"] = "RCP";
L["Clear"] = "Claro"; -- As in clearing a window or data
L["Close"] = "Fechar";
L["Close on award"] = "Fechar no prêmio";
L["Close on start"] = "Fechar no início";
L["Communication"] = "Comunicação";
L["Sent %s of %s bytes"] = "Enviou %s de %s bytes";
L["c"] = "c";
L["Cut"] = "Corte";
L["Cuts"] = "Cortes";
L["Can't send mail when the mailbox is closed"] = "Não é possível enviar e-mails quando a caixa de correio está fechada";
L["Multiple mail errors detected, aborting cut distribution"] = "Vários erros de e-mail detectados, abortando a distribuição cortada";
L["You don't owe %s any gold"] = "Você não deve ouro a %s";
L["Failed to send cut to %s"] = "Falha ao enviar corte para %s";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "Correio ENVIADO de acordo com o jogo, mas o OURO restante NÃO CORRESPONDE, algo deu errado?";
L["Mail History for |c00967FD2%s"] = "Histórico de e-mail para |c00967FD2%s";
L["You don't have enough gold to pay %s"] = "Você não tem ouro suficiente para pagar %s";
L["Wait a bit, we're still processing the previous mail"] = "Espere um pouco, ainda estamos processando o e-mail anterior";
L["Gargul GDKP: %sg"] = "Gargul GDKP: %sg";
L["Sent %sg to %s"] = "Enviou %sg para %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "Excluir";
L["Details"] = "Detalhes";
L["DFT"] = "DFT";
L["Disable"] = "Desativar";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "Desencantar";
L["Edit"] = "Editar";
L["Enable"] = "Habilitar";
L["Export"] = "Exportar";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "Tem certeza de que deseja remover toda a tabela do histórico de recompensas? Isso exclui TODOS os dados de saque e não pode ser desfeito!";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "Tem certeza de que deseja remover todos os dados de %s? Isto não pode ser desfeito!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
Este é APENAS um recurso de exportação, não faz sentido editar nenhum dos valores: ELES NÃO SERÃO SALVOS!

]];
L["Fill"] = "Preencher";
L["Final Call"] = "Última chamada";
L["Finish"] = "Terminar";
L["Format"] = "Formatar";
L["Gargul"] = "Gárgula";
L["GDKP"] = "RGPD";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "Os ataques GDKP não são permitidos nesta versão do World of Warcraft";
L["GDKP Active!"] = "GDKP ativo!";
L["Add dropped loot to queue"] = "Adicionar itens descartados à fila";
L["Gold (- for removing gold)"] = "Ouro (- para remover ouro)";
L["Who pays for this?"] = "Quem paga por isso?";
L["Gold needs to be lower/higher than 0"] = "O ouro precisa ser menor/maior que 0";
L["Paid for by"] = "Pago por";
L["Adjust gold in %s"] = "Ajuste o ouro em %s";
L["You can't give AND receive gold from the same player at the same time"] = "Você não pode dar E receber ouro do mesmo jogador ao mesmo tempo";
L["All cuts were mailed!"] = "Todos os cortes foram enviados!";
L["Disable for disenchanted"] = "Desativar para desencantado";
L["Disable in combat"] = "Desativar em combate";
L["Auctions"] = "Leilões";
L["Created by"] = "Criado por";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Excluído por %s
Razão: %s]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%sg adicionado ao pote por %s
Notas]];
L["Won by"] = "Venceu por";
L["Set paid amount (read left)"] = "Definir valor pago (leia à esquerda)";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul monitora automaticamente o ouro negociado. Contanto que os jogadores paguem
pelo que eles compraram, você nunca deveria precisar deste campo

'Valor pago' refere-se à quantidade de ouro que o comprador já negociou com você.
Isso não altera o preço real do item!

Atenção: só defina um valor aqui se o jogador prometer pagar
fora do ataque ou negocia o ouro de um alt/mail etc!


]];
L["GDKP Price:"] = "Preço do PIB:";
L["Award %s to %s for %s?"] = "Conceder %s a %s por %s?";
L["Auto Bid"] = "Lance automático";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "Qual é o seu lance máximo? (Mínimo %s|c00FFF569g)";
L["Bid denied!"] = "Lance negado!";
L["Min bid: %sg   Increment: %sg"] = "Lance mínimo: %sg Incremento: %sg";
L["(max %sg)"] = "(máximo %sg)";
L["New bid"] = "Novo lance";
L["Stop Auto Bid"] = "Interromper lance automático";
L["Top bid: %s by %s"] = "Lance máximo: %s por %s";
L["Top bid: %s by you"] = "Lance máximo: %s seu";
L["Create a new GDKP session"] = "Crie uma nova sessão do GDKP";
L["Management Cut %"] = "% de corte de gerenciamento";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Management Cut precisa estar vazio ou entre 0 e 99 (sem sinal de %!)";
L["Choose a session type!"] = "Escolha um tipo de sessão!";
L["Switch to this session"] = "Mudar para esta sessão";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFFO Multi-Leilão permite que você inicie lances em vários itens de uma vez, acelerando as coisas!
Siga as instruções após criar esta sessão para começar

Com |c00A79EFFSleilão Único você escolhe leiloar itens únicos ou usar a fila

Selecionar |c00A79EFFMulti-Auction evita que itens descartados sejam adicionados à fila
Você pode misturar |c00A79EFFMulti-Auction com |c00A79EFFSingle-Auction e a fila, mas desaconselhamos fortemente isso

]];
L["Auction type (|c00A79EFFi for more info)"] = "Tipo de leilão (|c00A79EFFi para mais informações)";
L["Multi-Auction"] = "Leilão múltiplo";
L["Single-Auction"] = "Leilão Único";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "Sessão criada. Aconselhamos você a usar /reload para que ele seja armazenado corretamente caso seu jogo trave!";
L["Add Raider"] = "Adicionar Invasor";
L["adjust [g]"] = "ajustar [g]";
L["adjust [%]"] = "ajustar [%]";
L["Announce the base cut in group chat"] = "Anuncie o corte básico no chat em grupo";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "Tem certeza de que deseja redefinir todos os jogadores e cálculos? Nota: todos os jogadores que não estiverem mais na raid serão removidos da lista!";
L["Delete Raider"] = "Excluir invasor";
L["Edit Raider"] = "Editar invasor";
L["Lock and Pay"] = "Bloquear e Pagar";
L["Manage gold trades"] = "Gerenciar negociações de ouro";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

Com mutadores você pode dar mais ou menos ouro aos jogadores
Exemplo: dar 2% a mais aos tanques é para que servem os mutadores!

Nota: Editar ou excluir modificadores aqui apenas os altera para esta sessão

]];
L["Not in the raid"] = "Não no ataque";
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
L["%s Raiders | %s With cut | Total payout: %s"] = "%s Invasores | %s Com corte | Pagamento total: %sg";
L["Nothing to import, double check your CSV"] = "Nada para importar, verifique seu CSV";
L["Missing gold for player %s"] = "Faltando ouro para o jogador %s";
L["Missing header, note: it's case-sensitive!"] = "Cabeçalho ausente, observação: diferencia maiúsculas de minúsculas!";
L["Missing player name"] = "Nome do jogador ausente";
L["Delete bid. Auction must be stopped first!"] = "Excluir lance. O leilão deve ser interrompido primeiro!";
L["Add a raider to this session"] = "Adicione um raider a esta sessão";
L["Custom (create your own format)"] = "Personalizado (crie seu próprio formato)";
L["Detailed (JSON)"] = "Detalhado (JSON)";
L["Share (can be imported by other players)"] = "Compartilhar (pode ser importado por outros jogadores)";
L["Your custom format"] = "Seu formato personalizado";
L["Your custom header"] = "Seu cabeçalho personalizado";
L["Custom (create your own format)"] = "Personalizado (crie seu próprio formato)";
L["@PLAYER,@CUT"] = "@JOGADOR,@CUT";
L["Player,Cut"] = "Jogador, Corte";
L["date/time at which the session was locked"] = "data/hora em que a sessão foi bloqueada";
L["total gold given to the player"] = "ouro total dado ao jogador";
L["gold mailed to the player"] = "ouro enviado ao jogador";
L["total gold received from the player"] = "total de ouro recebido do jogador";
L["date/time at which the first item was awarded"] = "data/hora em que o primeiro item foi concedido";
L["gold traded to the player"] = "ouro negociado com o jogador";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "Item, Jogador, Ouro, Wowheadlink";
L["Date/time at which the first item was awarded"] = "Data/hora em que o primeiro item foi concedido";
L["The title of the GDKP session"] = "O título da sessão GDKP";
L["Include disenchanted items"] = "Incluir itens desencantados";
L["Pot changed"] = "Pote alterado";
L["Gold Trades"] = "Negociações de Ouro";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "Tem certeza? Você não poderá ver ou dar lances em itens futuros!";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! AVISO!!|r

Você está em um reino conectado e está importando nomes de jogadores sem
um sufixo de domínio, '%s' por exemplo. Isso pode fazer com que você envie
corta e corta e-mails para o jogador errado.

Quando estiver em um reino conectado, sempre tente incluir o nome do reino dos jogadores!

Continuar importando?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "Isso substituirá todas as alterações feitas na janela de corte, tem certeza?";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Você pode importar cortes de jogadores de seus próprios cálculos, como uma planilha do Google. softwares GDKP etc.

O formato é o seguinte (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Jogador,Ouro|c00967FD2
Jogador1.4000
Jogador2,4125
Jogador3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
Importe preços mínimos e incrementos do GDKP.

O formato é o seguinte: ItemID + mínimo ou incremento são obrigatórios. (|c00BE3333REQUER UM CABEÇALHO!!):

|c00BE3333ItemID,Mínimo,Incremento|c00967FD2
18608.4000.500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "Excluir configurações de preço existentes? Clique em sim para excluir todos os dados de preços e em não para simplesmente substituir os existentes pelos dados fornecidos aqui";
L["Import GDKP Session"] = "Importar sessão do GDKP";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "Aqui você pode importar (e continuar) uma sessão do GDKP. Para obter uma sessão GDKP de alguém, ele precisa exportá-la para |c00FFF569/gdkp, onde seleciona o formato 'Compartilhar (pode ser importado por outros jogadores)'";
L["You're about to import a GDKP session created by %s, are you sure?"] = "Você está prestes a importar uma sessão do GDKP criada por %s, tem certeza?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "Esta sessão do GDKP criada por %s parece já existir. Deseja substituí-la?";
L["Invalid data provided for GDKP extension!"] = "Dados inválidos fornecidos para extensão GDKP!";
L["Invalid data provided for GDKP reschedule!"] = "Dados inválidos fornecidos para reagendamento do GDKP!";
L["Invalid data provided for GDKP shortening!"] = "Dados inválidos fornecidos para redução do GDKP!";
L["Invalid data provided for GDKP auction start!"] = "Dados inválidos fornecidos para início do leilão GDKP!";
L["Invalid number provided for 'paid'"] = "Número inválido fornecido para 'pago'";
L["Invalid time provided in Auction:reschedule"] = "Tempo inválido fornecido no leilão: reprogramar";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP Dados (vendidos %sx)
Última venda por: %s
Preço médio: %s
Lance mínimo: %s
Incremento: %s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "Saldo: |c0092FF000 ? Você é quadrado! | |c00BE333330? você deve %s 30g | |c00F7922E50? %s lhe deve 50g";
L["Gold mailed to you by %s"] = "Ouro enviado para você por %s";
L["Gold paid to %s"] = "Ouro pago a %s";
L["Gold received from %s"] = "Ouro recebido de %s";
L["Gold %s by"] = "Ouro %s por"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "Pote total: %sg | Corte de gestão: %sg (%s%%) | Para distribuir: %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s | Por %s%s | Em |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "A sessão do GDKP não está disponível ou bloqueada";
L["Mail All"] = "Enviar tudo";
L["No bids on Legendary+ item detected, continue manually!"] = "Nenhum lance no item Legendary+ detectado, continue manualmente!";
L["Missing content in Auction:start"] = "Conteúdo ausente no leilão: início";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

Com leilões múltiplos (ou leilões em lote), você pode leiloar quantos itens quiser de uma só vez!
Isso acelera imensamente suas noites de ataque e proporciona uma experiência perfeita para seus invasores

Todos os itens negociáveis ​​ainda em seu inventário podem ser leiloados automaticamente com 'Preencher do inventário'
Experimente!

|c00808080Há apenas uma desvantagem: para que as pessoas participem de um leilão em lote, os invasores precisarão de Gargul!

]];
L["You need to have an active (unlocked) GDKP session!"] = "Você precisa ter uma sessão GDKP ativa (desbloqueada)!";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "Com esta janela aberta, %s itens para adicioná-los à lista ou clique em 'Preencher do inventário' abaixo"; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "Anti-snipe em segundos";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "O valor anti-snipe precisa ser 0 (vazio) ou >=5";
L["Go back to the item selector"] = "Volte para o seletor de itens";
L["Remove all items from the list"] = "Remover todos os itens da lista";
L["Fill from inventory"] = "Preencher do inventário";
L["Add tradeable items from your inventory to the list"] = "Adicione itens negociáveis ​​do seu inventário à lista";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
Aqui você determina quais itens incluir em sua sessão de leilões múltiplos

Use o botão |c00A79EFFFFill from inventário abaixo para adicionar itens que ainda podem ser negociados à lista
Sempre que você limpar e reabrir esta janela, suas últimas configurações de preenchimento serão usadas para adicionar itens automaticamente

|c00A79EFF%s itens para adicioná-los manualmente à lista
]];
L["Next step: check raider's add-on version for compatibility"] = "Próxima etapa: verifique a compatibilidade da versão do complemento do raider";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "Nem todo mundo usa Gargul. Tem certeza de que deseja iniciar o leilão?";
L["Select at least one item for your auction"] = "Selecione pelo menos um item para o seu leilão";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Seu Gargul está desatualizado, recomendamos atualizá-lo antes de iniciar uma sessão para evitar problemas!";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "Nem todo mundo está atualizado. Se você estiver enfrentando problemas, diga aos seus invasores para atualizarem!";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "Há um leilão múltiplo ativo, os itens que você adicionar aqui serão adicionados à sessão existente. Esteja atento a itens duplicados!";
L["Search name or iLVL"] = "Nome de pesquisa ou iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "Suporta nomes de itens e iLVL, por ex. '252', '<252' etc.";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "Sessão ativa do GDKP: |c00967FD2%s | Por %s%s | Em |c00967FD2%s";
L["Auction time in seconds"] = "Tempo do leilão em segundos";
L["The auction time in seconds needs to be >= 10"] = "O tempo do leilão em segundos precisa ser >= 10";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "Você saiu durante a sessão de lances do GDKP. Para retomá-lo, você deve fornecer um novo tempo de lance (em segundos) para quaisquer itens não vendidos";
L["With this window open, %s items to add them to the list"] = "Com esta janela aberta, %s itens para adicioná-los à lista";
L["Click the cogwheel icon to manage an auction"] = "Clique no ícone da roda dentada para gerenciar um leilão";
L["You're already the top bidder on %s"] = "Você já é o maior licitante em %s";
L["Bid |c00%s%sg\nBy %s"] = [[
Lance |c00%s%sg
Por %s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%sFECHADO
Sem lances]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
Mínimo: |c00%s%sg
Incremento: |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "Itens: %s - Total vendido: %sg - prometido por mim: %sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
Itens com lances: %s/%s
Total vendido: %s
Comprado por mim: %s
Lance total (não inclui vendas): %s
Lance meu (não inclui vendido): %s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%sVENDIDO para
%s para |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
Lance |c00%s%sg
Por |c0092FF00VOCÊ!]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "Não foi possível interromper o lance automático em %s. Tente novamente ou /recarregue!";
L["Auto bid up to a maximum of %sg"] = "Lance automático até um máximo de %sg";
L["Auto bid up to the bid you fill in on the left"] = "Lance automático até o lance que você preencheu à esquerda";
L["Stop your auto bid (%sg)"] = "Interrompa seu lance automático (%sg)";
L["Bid on %s could not be confirmed"] = "Não foi possível confirmar o lance de %s";
L["Invalid bid or bid is too low! The minimum is %sg"] = "Lance inválido ou lance muito baixo! O mínimo é %sg";
L["You need to wait two seconds between bids on the same item"] = "Você precisa esperar dois segundos entre lances no mesmo item";
L["Clear bids"] = "Limpar lances";
L["Remove all bids from the auction"] = "Remover todos os lances do leilão";
L["Close all"] = "Feche tudo";
L["Close ALL auctions?"] = "Fechar TODOS os leilões?";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Fechar TODOS os leilões

Leilões com lances ativos serão vendidos e não poderão receber novos lances!
]];
L["Close Auction"] = "Fechar leilão";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "Feche o leilão. Os jogadores não podem mais dar lances, mas o lance mais alto permanece ativo";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "Remova o item do leilão, incluindo os detalhes do lance. ISSO NÃO PODE SER DESFEITO!";
L["Disenchant all finished but unsold items?"] = "Desencantar todos os itens acabados, mas não vendidos?";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
Desencantar itens não vendidos

Isso marcará todos os itens não vendidos como desencantados e eles não aparecerão em uma nova sessão de leilão múltiplo
]];
L["Favorite this item"] = "Favorite este item";
L["Give a final call timer of how many seconds?"] = "Dê um cronômetro de chamada final de quantos segundos?";
L["The minimum amount of seconds is 5"] = "A quantidade mínima de segundos é 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "Inicie uma chamada final para este leilão fornecendo um cronômetro de lance (geralmente mais curto)";
L["Close ALL auctions and wrap up this multi-auction session?"] = "Fechar TODOS os leilões e encerrar esta sessão de leilões múltiplos?";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Concluir sessão de leilão múltiplo

Isto fechará todos os leilões e anunciará o pote total no chat
Leilões com lances ativos serão vendidos e não poderão receber novos lances!
]];
L["Hide inactive"] = "Ocultar inativo";
L["Hide unusable"] = "Ocultar inutilizável";
L["Show/Hide finished auctions"] = "Mostrar/Ocultar leilões finalizados";
L["Manage Auction"] = "Gerenciar leilão";
L["Bid the minimum required amount"] = "Lance o valor mínimo exigido";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "Janela de lances fechada, use |c00A79EFF/gl bid para reabri-la!";
L["Announce sales in chat"] = "Anuncie vendas no chat";
L["Play sound when outbid"] = "Reproduzir som quando o lance for superado";
L["More sound options..."] = "Mais opções de som...";
L["Show all"] = "Mostre tudo";
L["Show favorites"] = "Mostrar favoritos";
L["Show inactive"] = "Mostrar inativo";
L["Show unusable"] = "Mostrar inutilizável";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "Este item foi vendido. Use o razão (|c00%s/gdkp) para fazer alterações!";
L["Terminate"] = "Encerrar";
L["Remove all bidsl bids and close all auctions?"] = "Remover todos os lances e fechar todos os leilões?";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
Encerrar sessão de leilão múltiplo

Isso excluirá todos os lances de itens que ainda não foram vendidos e fechará todos os leilões!
]];
L["Hover over any of the buttons below for more information"] = "Passe o mouse sobre qualquer um dos botões abaixo para obter mais informações";
L["Show/Hide items you can't use"] = "Mostrar/ocultar itens que você não pode usar";
L["Invalid data provided for GDKP auction start!"] = "Dados inválidos fornecidos para início do leilão GDKP!";
L["%s bought %s for %s"] = "%s comprou %s por %sg";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "O loot master (%s) está desatualizado, isso pode fazer com que os lances falhem!";
L["You were outbid!"] = "Você foi superado!";
L["Mutators"] = "Mutadores";
L["Add Mutator"] = "Adicionar mutador";
L["Auto apply to"] = "Aplicar automaticamente a";
L["Create a new GDKP mutator"] = "Crie um novo modificador GDKP";
L["Delete. Hold shift to bypass confirmation"] = "Excluir. Segure shift para ignorar a confirmação";
L["Edit mutator"] = "Editar modificador";
L["Flat gold rate [example: 250]"] = "Taxa fixa de ouro [exemplo: 250]";
L["The flat rate needs to be a number"] = "A taxa fixa precisa ser um número";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
Exemplo:
|c00967FD2SELF,RL,CURADOR]];
L["You can automatically apply this mutator to raiders using keywords:"] = "Você pode aplicar este modificador automaticamente aos invasores usando palavras-chave:";
L["Name [example: Tanks]"] = "Nome [exemplo: Tanques]";
L["Mutator names can not contains dots (.)"] = "Os nomes dos mutadores não podem conter pontos (.)";
L["Percentage [example: 10]"] = "Porcentagem [exemplo: 10]";
L["The percentage needs to be a number"] = "A porcentagem precisa ser um número";
L["Store for future sessions"] = "Armazenar para sessões futuras";
L["Unknown mutator: %s"] = "Mutador desconhecido: %s";
L["User '%s' is not allowed to start auctions"] = "O usuário '%s' não tem permissão para iniciar leilões";
L["User '%s' is not allowed to stop auctions"] = "O usuário '%s' não tem permissão para interromper leilões";
L["User '%s' is not allowed to stop auction: auction invalid"] = "O usuário '%s' não tem permissão para interromper o leilão: leilão inválido";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "Não há ouro suficiente para distribuir, espere alguns cálculos estranhos de corte!";
L["No bids!"] = "Sem lances!";
L["You were outbid!"] = "Você foi superado!";
L["(active)"] = "(ativo)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
Você precisa de chumbo ou saque mestre para ajustar o ouro.
Você não pode ajustar o ouro em sessões bloqueadas/excluídas]];
L["Add/Remove gold"] = "Adicionar/remover ouro";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s pagou |c00%s%s por
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Excluído por %s
Razão: %s]];
L["(deleted)"] = "(excluído)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
Você precisa de saque principal ou mestre para excluir entradas.
Você não pode excluir entradas em sessões bloqueadas/excluídas]];
L["Provide a reason for deleting this entry"] = "Forneça um motivo para excluir esta entrada";
L["Delete. Hold shift to bypass note"] = "Excluir. Segure shift para ignorar a nota";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "Sessões com leilões anexados serão excluídas após 48 horas";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
Você precisa de saque principal ou mestre para editar entradas.
Você não pode editar entradas excluídas ou entradas em sessões bloqueadas/excluídas]];
L["Export a session so others can view session details or even replace you as a loot master"] = "Exporte uma sessão para que outras pessoas possam ver os detalhes da sessão ou até mesmo substituí-lo como mestre de saque";
L["Import a session from another player or account"] = "Importe uma sessão de outro jogador ou conta";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
Mostrar uma visão geral completa do razão,
ideal para fins de captura de tela!]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "Bloquear uma sessão significa que você não pode leiloar itens ou alterar nada até desbloqueá-la, tem certeza?";
L["Lock or unlock the session"] = "Bloquear ou desbloquear a sessão";
L["Lock the session for payout"] = "Bloqueie a sessão para pagamento";
L["Multi-auction: auction multiple items at once!"] = "Leilão múltiplo: leiloe vários itens de uma vez!";
L["added to"] = "Adicionado a";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s pote por %s
Notas]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "removido de";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
Pote: %s
Corte gerencial (%s%%): %sg
Corte por jogador (1/%s): %sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
Você precisa de saque principal ou mestre para restaurar as entradas.
Você não pode restaurar entradas de sessões bloqueadas/excluídas]];
L["By %s%s | On |c00%s%s%s"] = "Por %s%s | Em |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "Desbloquear e alterar o pote ou cortes pode ser muito complicado, especialmente se você já tiver feito pagamentos. Tem certeza?";
L["Unlock the session"] = "Desbloquear a sessão";
L["No active GDKP session detected or session is not locked for payout!"] = "Nenhuma sessão ativa do GDKP detectada ou a sessão não está bloqueada para pagamento!";
L["Increment or minimum can't be lower than .0001!"] = "O incremento ou mínimo não pode ser inferior a 0,0001!";
L["Invalid 'Increment' provided for item ID '%s'"] = "'Incremento' inválido fornecido para o ID do item '%s'";
L["Invalid 'Minimum' provided for item ID '%s'"] = "'Mínimo' inválido fornecido para o ID do item '%s'";
L["Either minimum or increment is required for item ID: %s"] = "É necessário um mínimo ou incremento para o ID do item: %s";
L["Missing header, note: it's case-sensitive!"] = "Cabeçalho ausente, observação: diferencia maiúsculas de minúsculas!";
L["Successfully imported data for %s items"] = "Dados importados com sucesso para %s itens";
L["Unknown item ID: %s"] = "ID de item desconhecido: %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s itens em bolsas, janelas de saque ou até mesmo em links no seu chat para adicioná-los a esta fila de leilão.
Os itens na fila serão leiloados automaticamente assim que o leilão atual for concluído. Clique no botão '%s' para evitar isso.

Quer que Gargul premie ou desencante leilões automaticamente para você? Abra a roda de configurações no lado esquerdo!

|c00FFF569Você sabia?
Você pode mover itens arrastando e soltando
Os itens serão lembrados, mesmo quando você |c00A79EFF/recarregar
Os itens na fila são mostrados automaticamente aos invasores que possuem Gargul para que possam pré-oferecer
Gargul também pode cuidar do saque automático para você. Confira com |c00A79EFF/gl pm
]];
L["Hide unusable items"] = "Ocultar itens inutilizáveis";
L["GDKP Session"] = "Sessão GDKP";
L["Editing %s"] = "Editando %s";
L["Show upcoming items"] = "Mostrar próximos itens";
L["Stop the auction first!"] = "Pare o leilão primeiro!";
L["%s owes you %s"] = "%s lhe deve %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP Sessão
Gasto pelo jogador: %s
Dado: %s
Recebido: %s
Corte de jogador: %s

%s
]];
L["Exclude from GDKP"] = "Excluir do GDKP";
L["Gold traded will not be added to amount given or received"] = "O ouro negociado não será adicionado ao valor dado ou recebido";
L["Gold |c00967FD2given to %s"] = "Ouro |c00967FD2dado a %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "Não foi possível adicionar %s à janela de negociação. Tente adicioná-lo manualmente!";
L["You don't have enough money to pay %s"] = "Você não tem dinheiro suficiente para pagar %s";
L["To give: %s"] = "Para dar: %s";
L["To receive: %s"] = "Para receber: %s";
L["Gold |c00967FD2received from %s"] = "Ouro |c00967FD2recebido de %s";
L["Check out Multi Auctions!"] = "Confira Multi Leilões!";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "Siga as etapas abaixo para começar rapidamente a usar o Gargul GDKP!";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "Ative esta sessão clicando no botão |c00FFF569Enable abaixo!";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s um item para leiloar ou colocar um único item na fila"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
Comandos úteis:
- |c00FFF569/gdkp para abrir esta janela
- |c00FFF569/gl ma para abrir a janela de leilões múltiplos
- |c00FFF569/gl au para abrir o leiloeiro/fila de item único
- |c00FFF569/gl pm para configurar o saque automático

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "Se tudo correr bem, você verá seus itens recentemente leiloados aqui!";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "Quer leiloar vários itens de uma vez? Execute |c00FFF569/gl ma (ou |c00FFF569/gl multiauction) ou clique no ícone de multi-leilão no canto superior direito desta janela!";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "Clique no botão |c00FFF569Novo abaixo para criar sua primeira sessão GDKP. Ele será exibido à esquerda quando criado";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "Você está pronto para vender itens! |c00BE3333Leia todas as etapas abaixo com atenção e teste-as você mesmo (não há necessidade de participar de uma invasão) antes de iniciar sua primeira invasão do GDKP!";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "Quer vender um item sem ninguém licitar? |c00FFF569%s em um item, escolha um vencedor e defina um preço!";
L["Getting started"] = "Começando";
L["Unknown itemID in Auction:create: %s"] = "ID do item desconhecido no leilão:create: %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "SessionIdentifier desconhecido no leilão:create: %s";
L["You owe %s %s"] = "Você deve %s %s";
L["Given"] = "Dado";
L["g"] = "g";
L["Group"] = "Grupo";
L["Group Manager"] = "Gerente de grupo";
L["Download on CurseForge"] = "Baixe no CurseForge";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "Parar";
L["Header"] = "Cabeçalho";
L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"] = "|c00%sGargul v%s por Zhorax@Firemaw. Digite |c00%s/gl ou |c00%s/gargul para começar!";
L["Hide"] = "Esconder";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Visite o URL abaixo para saber mais sobre como personalizar Gargul GDKPs";
L["Your logo here? Click for more info!"] = "Seu logotipo aqui? Clique para mais informações!";
L["Import"] = "Importar";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "Importado em |c00A79EFF%s em |c00A79EFF%s, atualizado em |c00A79EFF%s em |c00A79EFF%s";
L["What kind of data would you like to import?"] = "Que tipo de dados você gostaria de importar?";
L["Import of boosted roll data successful"] = "Importação de dados de rolagem otimizada bem-sucedida";
L["Inc"] = "Inc.";
L["Include previously awarded items"] = "Incluir itens premiados anteriormente";
L["Include BOEs"] = "Incluir BOEs";
L["Include materials (like Abyss Crystals)"] = "Inclui materiais (como Cristais do Abismo)";
L["Increment"] = "Incremento";
L["Info"] = "Informações";
L["Invalid data supplied"] = "Dados inválidos fornecidos";
L["Item"] = "Item";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Não é possível decodificar dados JSON. Certifique-se de copiar/colar como está, sem adicionar caracteres adicionais ou espaços em branco!";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Teclas de atalho de item Gargul

Implementação: |c00A79EFF%s
Prêmio: |c00A79EFF%s
Desencantar: |c00A79EFF%s


-- Clique com o botão direito para desativar esta janela --
]];
L["Ledger"] = "Razão";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "Você precisa ser o mestre saqueador ou ter um papel de auxiliar/liderança!";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "Nota: você pode alterar o local a qualquer momento nas configurações ou via |c00%s/gl locale";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul posta mensagens de bate-papo em inglês (padrão)
Você pode selecionar um idioma diferente no menu suspenso abaixo

Seu idioma de bate-papo atual é '%s'. A ativação de um idioma diferente causará um /reload!
]];
L["Choose a chat language for Gargul"] = "Escolha um idioma de bate-papo para Gargul";
L["ptBR"] = "ptBR"; -- Portuguese (Brazil)
L["ruRU"] = "ruRU"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "Você tem um ou mais complementos instalados que podem causar mau funcionamento do Gargul: %s";
L["Clear SoftRes"] = "Limpar SoftRes";
L["Clear TMB"] = "Limpar TMB";
L["/roll for MS or /roll 99 for OS"] = "/roll para MS ou /roll 99 para OS";
L["Import SoftRes"] = "Importar SoftRes";
L["Import TMB"] = "Importar TMB";
L["You were given the role of Master Looter"] = "Você recebeu o papel de Mestre Looter";
L["Open this window automatically"] = "Abra esta janela automaticamente";
L["Loot priorities cleared successfully"] = "Prioridades de saque eliminadas com sucesso";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "Forneça um CSV prio no seguinte formato (1 linha por item): id ou nome > prio1, equalprio > prio2 > etc.";
L["Loot priorities imported successfully"] = "Prioridades de saque importadas com sucesso";
L["Invalid data provided"] = "Dados inválidos fornecidos";
L["Invalid data provided in line: '%s': missing item id or priority"] = "Dados inválidos fornecidos na linha: '%s': ID ou prioridade do item ausente";
L["Attempting to process incoming loot priorities from %s"] = "Tentando processar prioridades de saque recebidas de %s";
L["Loot Prio"] = "Saque Prio";
L["Mail"] = "Correspondência";
L["Mailed"] = "Enviou";
L["Mail cut to players"] = "Correio cortado para jogadores";
L["MS"] = "EM";
L["Maximize"] = "Maximizar";
L["Min"] = "Mínimo";
L["Awarded loot history"] = "Histórico de saques premiados";
L["GDKP Cuts"] = "Cortes do GDKP";
L["Export data"] = "Exportar dados";
L["Open Gargul"] = "Abrir Gárgula";
L["Import data"] = "Importar dados";
L["GDKP Ledger"] = "Razão GDKP";
L["Multiauction"] = "Multileilão";
L["Change settings in /gl minimap"] = "Alterar configurações no minimapa /gl";
L["Minimize"] = "Minimizar";
L["Minimize on award"] = "Minimizar o prêmio";
L["Minimize on start"] = "Minimizar no início";
L["Minimum"] = "Mínimo";
L["Minimum item level"] = "Nível mínimo do item";
L["Minimum Quality"] = "Qualidade Mínima";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "Mover";
L["Multi-Auction"] = "Leilão múltiplo";
L["Name"] = "Nome";
L["New"] = "Novo";
L["Next"] = "Próximo";
L["No"] = "Não";
L["None"] = "Nenhum";
L["Note"] = "Observação";
L["Nothing"] = "Nada";
L["When no one bids do:"] = "Quando ninguém dá lances, faça:";
L["You don't have officer privileges"] = "Você não tem privilégios de oficial";
L["OS"] = "SO";
L["Ok"] = "OK";
L["Open"] = "Abrir";
L["Open Auctioneer"] = "Leiloeiro aberto";
L["Open Multi-Auction"] = "Abrir multi-leilão";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "Definir %s como seu desencantador?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "Enviar %s para %s? Digite /gl cd para remover esse desencantador!";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "Nenhum conjunto de desencantador, use /gl sd [mydisenchanter] para definir um";
L["Who is your disenchanter?"] = "Quem é o seu desencantador?";
L["Paid"] = "Pago";
L["Pass"] = "Passar";
L["%"] = "%";
L["Player"] = "Jogador";
L["Items won by %s:"] = "Itens ganhos por %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "Mais uns";
L["Add a +1"] = "Adicionar um +1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "Tem certeza de que deseja transmitir seus dados de acompanhante para todos em seu grupo/raid?";
L["Attempting to process incoming PlusOnes data from %s"] = "Tentando processar dados recebidos de PlusOnes de %s";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s deseja limpar todos os seus dados do PlusOne. Limpar todos os dados?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "Tem certeza de que deseja limpar os dados existentes do PlusOne e importar novos dados transmitidos por %s?";
L["Are you sure you want to import new data broadcasted by %s?"] = "Tem certeza de que deseja importar novos dados transmitidos por %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Dados inválidos fornecidos. Certifique-se de que o conteúdo siga o formato exigido e que nenhuma linha de cabeçalho esteja incluída";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
Aqui você pode importar mais um dado de uma tabela em formato CSV ou TSV ou colado de uma planilha do Google Docs.

A tabela precisa de pelo menos duas colunas: O nome do jogador seguido da quantidade de pontos. Colunas adicionais são ignoradas.

Aqui está um exemplo de linha:

Foobar,240
]];
L["Automatically accept incoming broadcasts from %s"] = "Aceitar automaticamente transmissões recebidas de %s";
L["Block all incoming +1 shared data"] = "Bloquear todos os dados compartilhados +1 recebidos";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Tem certeza de que deseja atualizar seus dados existentes do PlusOne com dados de %s?

Sua atualização mais recente foi em |c00A79EFF%s, a deles em |c00A79EFF%s.]];
L["!plusone|!po|!+1"] = "!mais um|!po|!+1";
L["+"] = "+";
L["Pot"] = "Panela";
L["Price"] = "Preço";
L["PL"] = "PT";
L["Common"] = "Comum";
L["Epic"] = "Épico";
L["Heirloom"] = "Herança";
L["Legendary"] = "Lendário";
L["Poor"] = "Pobre";
L["Rare"] = "Cru";
L["Uncommon"] = "Incomum";
L["Queue"] = "Fila";
L["Raiders"] = "Invasores";
L["Who's Missing"] = "Quem está faltando";
L["Show missing player names"] = "Mostrar nomes de jogadores ausentes";
L["Disband raid"] = "Dissolver ataque";
L["Disband your raid"] = "Dissolva seu ataque";
L["%s is listed twice on the roster!"] = "%s está listado duas vezes na lista!";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "uma exportação |c00FFF569Raid-Helper (use a variante 'Grupos classificados verticalmente') ou um CSV de composição de grupo |c00FFF569Gargul:";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
Na grande caixa de edição abaixo você pode fornecer uma lista e: convidar todos, verificar quem está faltando, inscrever grupos e atribuir os tanques.

Você pode fornecer um link de composição de raid |c00FFF569Wowhead:]];
L["Gargul Group Wiki"] = "Wiki do Grupo Gargul";
L["Visit the Gargul group wiki for more info on the raid group format"] = "Visite o wiki do grupo Gargul para obter mais informações sobre o formato do grupo raid.";
L["The following players are not part of the roster: %s"] = "Os seguintes jogadores não fazem parte da escalação: %s";
L["Invalid group data provided, check your format!"] = "Dados de grupo inválidos fornecidos. Verifique seu formato!";
L["Invite"] = "Convidar";
L["Send invites to players on roster"] = "Envie convites para jogadores na escalação";
L["Can't sort groups while %s is in combat!"] = "Não é possível ordenar grupos enquanto %s está em combate!"; -- %s holds a player name
L["You need to be in a raid!"] = "Você precisa estar em um ataque!";
L["No tanks defined"] = "Nenhum tanque definido";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "Não consegue encontrar um lugar para %s. Você está tentando colocar mais de 5 pessoas em um grupo?";
L["Kick unwanted players"] = "Expulsar jogadores indesejados";
L["Kick players that aren't on the roster"] = "Expulsar jogadores que não estão no elenco";
L["Something went wrong while moving %s"] = "Algo deu errado ao mover %s";
L["Finished applying raid roster"] = "Concluída a aplicação da escalação da raid";
L["Sorting groups"] = "Classificando grupos";
L["Apply Groups"] = "Aplicar grupos";
L["Sort groups based on roster"] = "Classifique os grupos com base na lista";
L["Sorting is still in progress, wait a bit!"] = "A classificação ainda está em andamento, espere um pouco!";
L["All tanks are assigned"] = "Todos os tanques são atribuídos";
L["Assign Tanks"] = "Atribuir tanques";
L["Wowhead Comp Tool"] = "Ferramenta Wowhead Comp";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "Você pode visitar a ferramenta wowhead comp usando o URL abaixo. Depois de criar sua composição você pode colá-la aqui ou no grande campo de edição da janela do grupo Gargul";
L["Remove bid"] = "Remover lance";
L["Reset Settings"] = "Redefinir as configurações";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "Tem certeza de que deseja redefinir todas as configurações do Gargul? Isso não pode ser desfeito!";
L["Reset Gargul UI"] = "Redefinir interface do Gargul";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "Tem certeza de que deseja redefinir todos os tamanhos, posições e escala das janelas do Gargul? Isso não pode ser desfeito!";
L["Restore"] = "Restaurar";
L["Resume"] = "Retomar";
L[">"] = ">";
L["Roll"] = "Rolar";
L["Award %s to %s?"] = "Premiar %s para %s?";
L["Close on award"] = "Fechar no prêmio";
L["Close on start"] = "Fechar no início";
L["Hold shift to bypass the award confirmation"] = "Segure shift para ignorar a confirmação do prêmio";
L["Hold shift to show the award confirmation"] = "Segure shift para mostrar a confirmação do prêmio";
L["Warning: another identical roll was found which can point to a tie"] = [[
Atenção: foi encontrado outro lançamento idêntico que pode apontar para um empate

]];
L["Invalid data provided for roll start!"] = "Dados inválidos fornecidos para lançamento inicial!";
L["(BR: %s)"] = "(BR: %s)";
L["(item given: yes)"] = "(item fornecido: sim)";
L["(item given: no)"] = "(item dado: não)";
L["(OS)"] = "(SO)";
L["NOTE"] = "OBSERVAÇÃO";
L["Can't stop roll off, no roll off in progress"] = "Não consigo parar de rolar, não há rolagem em andamento";
L["Pass"] = "Passar";
L["rolls: %s"] = "rolos: %s";
L["Open master looter window"] = "Abrir janela mestre do saqueador";
L["Roll accepted!"] = "Rolo aceito!";
L["A roll is currently in progress"] = "Uma rolagem está em andamento";
L["Prio [%s]"] = "Prévio [%s]";
L["SR [%sx]"] = "RS [%sx]";
L["Wish [%s]"] = "Desejo [%s]";
L["You need to select a player first"] = "Você precisa selecionar um jogador primeiro";
L["TIMER (s)"] = "TEMPORIZADOR(es)";
L["You can't use this item!"] = "Você não pode usar este item!";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "O nome do vencedor não é único, selecione o jogador ao qual você gostaria de premiar %s";
L["s"] = "é";
L["Select / Disable all"] = "Selecionar/Desativar tudo";
L["Session"] = "Sessão";
L["Settings"] = "Configurações";
L["Announce incoming bids"] = "Anuncie lances recebidos";
L["Announce pot after awarding item"] = "Anuncie o pote após conceder o item";
L["Announce auction start"] = "Anunciar o início do leilão";
L["Announce countdown in raid warning"] = "Anuncie a contagem regressiva no aviso de ataque";
L["Announce incoming bids in raid warning"] = "Anuncie lances recebidos em aviso de invasão";
L["Reset Gargul UI"] = "Redefinir interface do Gargul";
L["Whisper bidder if bid is too low"] = "Sussurre o licitante se o lance for muito baixo";
L["s"] = "é";
L["Skip"] = "Pular";
L["Soft-Reserves"] = "Reservas suaves";
L["SR"] = "RS";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "Tem certeza de que deseja transmitir seus dados de softres para todos em seu grupo/raid?";
L["Couldn't process SoftRes data received from %s"] = "Não foi possível processar os dados SoftRes recebidos de %s";
L["Are you sure you want to clear all existing soft-reserve data?"] = "Tem certeza de que deseja limpar todos os dados de reserva temporária existentes?";
L["Everyone filled out their soft-reserves"] = "Todos preencheram suas reservas suaves";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
As informações sobre reservas definitivas não estão disponíveis porque as reservas flexíveis
fornecidos não foram gerados usando o botão 'Gargul Export' em softres.it]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "Importado em |c00A79EFF%s em |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "Correção automática de nome: o SR de '%s' agora está vinculado a '%s'";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "Para começar, primeiro você precisa criar um ataque em softres.it. Em seguida clique em ‘Addon Export’, selecione ‘Gargul’, copie os dados e cole no formulário abaixo.";
L["Invalid soft-reserve data provided"] = "Dados de reserva temporária inválidos fornecidos";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "Dados inválidos fornecidos. Certifique-se de clicar no botão 'Gargul Export' em softres.it e cole o conteúdo completo aqui";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "Os valores PlusOne fornecidos colidem com os já presentes. Você deseja substituir seus antigos valores PlusOne?";
L["The following players did not reserve anything:"] = "Os seguintes jogadores não reservaram nada:";
L["Soft-reserves imported successfully"] = "Reservas temporárias importadas com sucesso";
L["Import successful!"] = "Importação bem sucedida!";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "SoftRes Weakaura e dados CSV estão obsoletos, use a exportação Gargul!";
L["Failed to connect to LootReserve, contact support (include message below)"] = "Falha ao conectar-se ao LootReserve, entre em contato com o suporte (inclua a mensagem abaixo)";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "Nenhum URL softres.it disponível, certifique-se de exportar usando o botão 'Gargul Export' em softres.it!";
L["Click here to see hard-reserve info"] = "Clique aqui para ver informações sobre reservas definitivas";
L["No items are hard-reserved"] = "Nenhum item é reservado";
L["No hard-reserve info available"] = "Nenhuma informação de reserva física disponível";
L["Post missing SRs"] = "Postar RSs ausentes";
L["Post SR URL"] = "URL da postagem SR";
L["This player did not reserve anything!"] = "Este jogador não reservou nada!";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "Tentando processar dados SoftRes recebidos de %s";
L["This item is hard-reserved"] = "Este item é reservado";
L["For: %s"] = "Para s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 Nota: %s";
L["Reserved by"] = "Reservado por";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "Algo deu errado!";
L["Start"] = "Começar";
L["Stop"] = "Parar";
L["\\t is replaced by a tab"] = "\\t  is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "Tempo";
L["Title"] = "Título";
L["TMB, DFT or PRIO3"] = "TMB, DFT ou PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "Tem certeza de que deseja transmitir seus dados TMB para todos no seu grupo/raid? NB: TODOS podem ver seus dados do TMB, independentemente de suas permissões no site do TMB!";
L["Attempting to process incoming TMB data from %s"] = "Tentando processar dados TMB recebidos de %s";
L["Are you sure you want to clear all plus one data?"] = "Tem certeza de que deseja limpar todos os dados mais um?";
L["Clear Raider Data"] = "Limpar dados do Raider";
L["Clear TMB data for all raiders?"] = "Limpar dados TMB para todos os invasores?";
L["Auto-sharing enabled: %s"] = "Compartilhamento automático ativado: %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Na execução do classicpr.io, clique no botão 'Gargul Export' e copie o conteúdo. Depois cole o conteúdo como está na caixa abaixo e clique em 'Importar'. É isso!";
L["Imported on ${date} at ${time}"] = "Importado em ${date} às ${time}";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Exporte seus dados DFT de acordo com as instruções da planilha. Depois cole o conteúdo como está na caixa abaixo e clique em 'Importar'. É isso!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "CSV inválido fornecido, o formato é: 6948,player1,player2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "Dados DFT inválidos fornecidos. Exporte seus dados DFT de acordo com as instruções da planilha e cole o conteúdo aqui como está!";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "Dados TMB inválidos fornecidos, certifique-se de clicar no botão 'Download' na seção Gargul e colar o conteúdo aqui como está!";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "Dados TMB ou DFT inválidos fornecidos, certifique-se de colar o conteúdo de exportação aqui como está!";
L["Priority notes available: %s"] = "Notas prioritárias disponíveis: %s";
L["Number of items imported: %s"] = "Número de itens importados: %s";
L["The following players have no %s entries:"] = "Os seguintes jogadores não têm %s entradas:"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "Como usar Gargul com ${source}";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "Cole o conteúdo de exportação do TMB como está na caixa abaixo e clique em 'Importar'";
L["There's no one in your group to broadcast to"] = "Não há ninguém no seu grupo para quem transmitir";
L["TMB data synced"] = "Dados TMB sincronizados";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF Nota: |c00FFF569%s";
L["(OS)"] = "(SO)";
L["%s Prio List"] = "%s Lista Prévia"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF Camada: %s";
L["TMB Wish List"] = "Lista de desejos TMB";
L["Show/Hide Dates"] = "Mostrar/ocultar datas";
L["Show/Hide Queue"] = "Mostrar/ocultar fila";
L["%s to award loot!"] = "%s para conceder itens!";
L["%s to roll out loot!"] = "%s para distribuir saques!";
L["Hide all awarded items"] = "Ocultar todos os itens premiados";
L["Hide disenchanted items"] = "Ocultar itens desencantados";
L["Hide items awarded to self"] = "Ocultar itens concedidos a si mesmo";
L["Announce Trade"] = "Anunciar negociação";
L["Announce trade details to group or in /say when not in a group"] = "Anuncie detalhes da negociação para o grupo ou em /say quando não estiver em um grupo";
L["Tutorial"] = "Tutorial";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s itens em bolsas, janelas de saque ou até mesmo em links no seu chat para adicioná-los à fila do leilão.
Quer vender um item diretamente sem licitar? Usar |c00A79EFF%s

Você pode abrir a janela %s diretamente digitando |c00A79EFF/gl leilão

Gargul rastreia |c00FF0000TODO ouro negociado. Não quer que uma negociação faça parte desta sessão do GDKP? Marque a caixa de seleção 'Excluir do GDKP' ao negociar!

|c00FFF569Você sabia?
Os itens premiados serão adicionados automaticamente à janela de negociação
Gargul também pode cuidar do saque automático para você. Confira com |c00A79EFF/gl pm
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
Esta janela mostra todos os itens que foram premiados em uma determinada data (selecione uma ou mais datas à esquerda).

Os itens podem conter as seguintes tags:

|c00A79EFFOS: Concedido por offspec
|c00A79EFFSR: Este item foi reservado de forma temporária
|c00A79EFFWL: Este item foi colocado na lista de desejos (Thatsmybis)
|c00A79EFFPL: Este item foi colocado na lista prio (Thatsmybis, DFT, prio3)
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
Os itens que você vê aqui estão na fila GDKP do saqueador mestre
Você pode removê-los, dar lances neles e ocultar itens inutilizáveis ​​(ative 'Ocultar itens inutilizáveis' nas configurações no canto superior esquerdo)

Você pode redimensionar a janela, movê-la ou minimizá-la. Experimente!

Para mestres de saque: remover itens aqui apenas os removerá da sua fila pessoal, não da fila real do GDKP!
]];
L["Need more help?"] = "Precisa de mais ajuda?";
L["Type"] = "Tipo"; -- As in type of roll or type of item
L["unknown"] = "desconhecido";
L["Unknown comm action '%s', make sure to update Gargul!"] = "Ação de comunicação desconhecida '%s', certifique-se de atualizar o Gargul!";
L["Unlock"] = "Desbloquear";
L["Update Gargul!"] = "Atualize Gargul!";
L["v"] = "v";
L["Report"] = "Relatório";
L["Report outdated results in group chat"] = "Relate resultados desatualizados no bate-papo em grupo";
L["Gargul status"] = "Status de gárgula";
L["Checking version ..."] = "Verificando versão...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s: o player está atualizado
|c00F7922Ev%s: o jogador precisa atualizar seus add-ons
|c00BE3333%s: o player não tem Gargul ou está em uma versão não suportada
|c00808080%s: o jogador está offline ou nos ignorando!
|c0000FFFF%s: o jogador está na nossa lista de ignorados!

]];
L["PLAYER IGNORED!"] = "JOGADOR IGNORADO!";
L["Offline"] = "desligada";
L["No response"] = "Sem resposta";
L["No response:"] = "Sem resposta:";
L["Offline:"] = "Desligada:";
L["Outdated:"] = "Desatualizado:";
L["Up-to-date:"] = "Atualizado:";
L["Gargul is out of date and won't work until you update!"] = "Gargul está desatualizado e não funcionará até que você atualize!";
L["Invalid version string provided in Version:addRelease"] = "String de versão inválida fornecida em Version:addRelease";
L["Update Gargul!"] = "Atualize Gargul!";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul agora está atualizado para |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s está disponível em CurseForge/Wago. Você pode atualizar sem fechar o jogo, apenas certifique-se de /reload !";
L["Wait %s more seconds before you retry"] = "Aguarde mais %s segundos antes de tentar novamente";
L["Window"] = "Janela";
L["Gargul v%s"] = "Gárgula v%s";
L["Window Scale"] = "Escala da janela";
L["WL"] = "WL";
L["Yes"] = "Sim";
L["You disabled GDKP queues"] = "Você desativou as filas do GDKP";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "Não é possível compactar os dados com zlib. Contate o suporte via https://discord.gg/D3mDhYPVzf";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Não foi possível descompactar os dados pelo zlib. Certifique-se de copiar/colar como está, sem adicionar caracteres adicionais ou espaços em branco!";
