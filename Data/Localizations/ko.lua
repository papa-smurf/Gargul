--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "koKR") then return; end
]]
if (GetLocale() ~= "koKR") then return; end
local L = Gargul_L or {};

L["About"] = "에 대한";
L["All Settings"] = "모든 설정";
L["Announce"] = "발표하다";
L["Anti Snipe"] = "안티 스나이프";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Anti Snipe 값이 10이라는 것은
10초도 채 남지 않으면 타이머가 다시 10초로 재설정됩니다.

이 항목을 비워두거나 0으로 설정하여 Anti Snipe를 완전히 비활성화할 수 있습니다.
5 미만의 Anti Snipe 값은 지원되지 않습니다.

]];
L["Are you sure?"] = "확실합니까?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
대신 Gargul을 사용하는 것을 잊지 마세요
나중에 전리품을 내보내고 싶다면


-- 이 창을 비활성화하려면 마우스 오른쪽 버튼을 클릭하세요 --]];
L["Auction"] = "경매";
L["Auctioneer"] = "경매인";
L["Auctions"] = "경매";
L["Auto"] = "자동";
L["Auto award"] = "자동상";
L["Auto trade"] = "자동거래";
L["Available values:"] = "사용 가능한 값:";
L["Award"] = "상";
L["Awarded To"] = "수여 대상";
L["BR: %s"] = "BR: %s";
L["Price: %s"] = "가격: %s";
L["Given: yes"] = "주어진 : 예";
L["Given: no"] = "주어진 : 아니오";
L["2nd bid: %s by %s"] = "두 번째 입찰: %s by %s";
L["You won"] = "당신이 이겼어요";
L["Award %s to %s?"] = "%s을(를) %s에게 수여하시겠습니까?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "정말로 %s의 마법을 해제하시겠습니까? %s의 증가된 롤 포인트가 환불됩니다!";
L["In Group"] = "그룹에서";
L["Award history"] = "수상 내역";
L["Who should %s go to instead?"] = "%s 대신 누구에게 가야 할까요?";
L["Type player name here"] = "여기에 플레이어 이름을 입력하세요.";
L["or select one below"] = "또는 아래 중 하나를 선택하세요.";
L["Do you want to award %s to a random player?"] = "무작위 플레이어에게 %s 상을 주시겠습니까?";
L["Drag and drop or shift+click an item in the box on the right"] = "오른쪽 상자에 있는 항목을 드래그 앤 드롭하거나 Shift+클릭하세요.";
L["(BR: %s)"] = "(BR: %s)";
L["Disenchanted items:"] = "마력 추출된 아이템:";
L["(Given: yes)"] = "(제공: 예)";
L["(Given: no)"] = "(주어진: 아니오)";
L["(OS)"] = "(OS)";
L["%s boosted roll points will be refunded!"] = "%s의 증가된 롤 포인트가 환불됩니다!";
L["Are you sure you want to undo %s awarded to %s?%s"] = "%s이(가) %s에게 부여된 것을 실행 취소하시겠습니까?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "가방 검사 실패: 보고된 내용이 없습니다.";
L["Inspection finished"] = "검사완료";
L["Starting inspection..."] = "점검 시작...";
L["Balance"] = "균형";
L["Base"] = "베이스";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Base64로 데이터를 디코딩할 수 없습니다. 추가 문자나 공백을 추가하지 않고 있는 그대로 복사하여 붙여넣으세요!";
L["Bid"] = "매기다";
L["Bids"] = "입찰";
L["BOE"] = "BOE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. 레이드 가입 시 자동으로 그룹 초대/정렬 가능! 아래를 클릭하거나 |c00A79EFF/gl gr을 사용하세요.";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. 단골이 되거나 더 많은 노력을 기울이는 플레이어에게 보상을 주세요! 아래를 클릭하거나 |c00A79EFF/gl br을 사용하세요.";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul에는 여러분이 알지 못할 수도 있는 몇 가지 트릭이 있습니다. 멋져보세요!";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul에는 플러스원 추적 시스템이 포함되어 있습니다! 아래를 클릭하거나 |c00A79EFF/gl po를 사용하세요.";
L["Boosted Rolls"] = "부스트 롤";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
현재 공격대에 있는 모든 사람에게 몇 점을 추가합니까?

|c00BE3333부스트 롤 항목이 없는 사람이라도 모든 사람이 포인트를 얻을 수 있도록 하려면 먼저 '누락된 침입자 추가' 버튼을 사용하세요!]];
L["No point value provided!"] = "포인트 값이 제공되지 않습니다!";
L["Add points to raid"] = "레이드에 포인트 추가";
L["Add missing raiders"] = "누락된 침입자 추가";
L["Aliases"] = "별칭";
L["Apply aliases"] = "별칭 적용";
L["Boosted Roll Cost:"] = "부스트 롤 비용:";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "부스트 롤 데이터를 파티/레이드의 모든 사람에게 방송하시겠습니까?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "방송할 것이 없습니다. 먼저 Boosted Rolls 데이터를 가져오세요!";
L["Couldn't process BoostedRolls data received from %s"] = "%s에서 받은 BoostedRolls 데이터를 처리할 수 없습니다.";
L["Attempting to process incoming BoostedRolls data from %s"] = "%s에서 들어오는 BoostedRolls 데이터를 처리하려고 시도하는 중입니다.";
L["Are you sure you want to clear all boosted roll data?"] = "모든 부스트 롤 데이터를 삭제하시겠습니까?";
L["Delete %s?"] = "%s을(를) 삭제하시겠습니까?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "기존 부스트 롤 데이터를 지우고 %s에서 방송하는 새 데이터를 가져오시겠습니까?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "잘못된 데이터가 제공되었습니다. 내용이 필수 형식을 따르고 헤더 행이 포함되어 있지 않은지 확인하세요.";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
여기서는 CSV 또는 TSV 형식의 테이블에서 부스트 롤 데이터와 별칭을 가져오거나 Google Docs 시트에서 붙여넣을 수 있습니다.

테이블에는 플레이어 이름과 포인트 금액이라는 두 개 이상의 열이 필요합니다. 추가 열은 선택 사항이며 플레이어의 별칭을 포함할 수 있습니다.
다음은 예시 라인입니다:

푸바,240,바푸]];
L["Points"] = "포인트들";
L["Reserve"] = "예약하다";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
%s의 데이터로 기존 부스트 롤을 업데이트하시겠습니까?

귀하의 최신 업데이트는 |c00A79EFF%s에 있었고, 해당 업데이트는 |c00A79EFF%s에 있었습니다.]];
L["!bonus|!rb|!br"] = "!보너스|!rb|!br";
L["Broadcast"] = "방송";
L["Broadcasting..."] = "방송...";
L["You are currently in combat, delaying broadcast"] = "현재 전투 중이므로 방송이 지연되고 있습니다.";
L["Broadcast finished!"] = "방송완료!";
L["Include awarded items"] = "수여된 항목 포함";
L["Include disenchanted items"] = "마력 추출된 아이템 포함";
L["Include hidden items"] = "숨겨진 항목 포함";
L["Include time left"] = "남은 시간 포함";
L["Broadcast still in progress"] = "방송은 아직 진행 중";
L["There is nothing to broadcast"] = "방송할 일이 없네";
L["Number of items"] = "항목 수";
L["Broadcast ${percentage}%"] = "방송 ${percentage}%";
L["Target player (whisper only)"] = "대상 플레이어(속삭임만)";
L["Whisper requires a target player"] = "속삭임에는 대상 플레이어가 필요합니다";
L["Max trade time left (in minutes)"] = "남은 최대 거래 시간(분)";
L["by"] = "~에 의해"; -- As in 'bid BY'
L["Cancel"] = "취소";
L["Get support or share ideas on our Discord"] = "Discord에서 지원을 받거나 아이디어를 공유하세요";
L["Enable changelog"] = "변경 로그 활성화";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul을 사용하면 전리품을 매우 쉽게 나눠줄 수 있습니다. 시작하려면 아래 버튼을 클릭하세요!";
L["Open Gargul"] = "오픈 가르굴";
L["Adjust Scale"] = "규모 조정";
L["Channel"] = "채널";
L["Officer"] = "장교";
L["Raid Warning"] = "습격 경고";
L["Whisper"] = "속삭임";
L["CPR"] = "심폐소생술";
L["Clear"] = "분명한"; -- As in clearing a window or data
L["Close"] = "닫다";
L["Close on award"] = "수상 마감";
L["Close on start"] = "시작 시 닫기";
L["Communication"] = "의사소통";
L["Sent %s of %s bytes"] = "%s/%s바이트를 보냈습니다.";
L["c"] = "c";
L["Cut"] = "자르다";
L["Cuts"] = "컷";
L["Can't send mail when the mailbox is closed"] = "사서함이 닫혀 있으면 메일을 보낼 수 없습니다";
L["Multiple mail errors detected, aborting cut distribution"] = "다수의 메일 오류가 감지되어 컷 배포가 중단되었습니다.";
L["You don't owe %s any gold"] = "%s의 금이 없습니다.";
L["Failed to send cut to %s"] = "%s에 컷을 보내지 못했습니다.";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "게임에 따라 메일이 전송되었지만 남은 GOLD가 일치하지 않습니다. 문제가 발생했나요?";
L["Mail History for |c00967FD2%s"] = "|c00967FD2%s에 대한 메일 기록";
L["You don't have enough gold to pay %s"] = "%s에 지불할 골드가 부족합니다.";
L["Wait a bit, we're still processing the previous mail"] = "잠시만 기다려주세요. 아직 이전 메일을 처리하는 중입니다.";
L["Gargul GDKP: %sg"] = "가르굴 GDKP: %sg";
L["Sent %sg to %s"] = "%sg을(를) %s로 보냈습니다.";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "삭제";
L["Details"] = "세부";
L["DFT"] = "DFT";
L["Disable"] = "장애를 입히다";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "마력 추출";
L["Edit"] = "편집하다";
L["Enable"] = "할 수 있게 하다";
L["Export"] = "내보내다";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "전체 보상 내역 테이블을 삭제하시겠습니까? 이렇게 하면 모든 전리품 데이터가 삭제되며 취소할 수 없습니다!";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "%s에 대한 모든 데이터를 제거하시겠습니까? 이 취소 할 수 없습니다!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
이것은 내보내기 기능일 뿐이므로 값을 편집할 필요가 없습니다. 값은 저장되지 않습니다!

]];
L["Fill"] = "채우다";
L["Final Call"] = "최종 호출";
L["Finish"] = "마치다";
L["Format"] = "체재";
L["Gargul"] = "가르굴";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "이 버전의 월드 오브 워크래프트에서는 GDKP 공격대가 허용되지 않습니다.";
L["GDKP Active!"] = "GDKP 액티브!";
L["Add dropped loot to queue"] = "대기열에 떨어진 전리품 추가";
L["Gold (- for removing gold)"] = "금(-금 제거용)";
L["Who pays for this?"] = "누가 비용을 지불합니까?";
L["Gold needs to be lower/higher than 0"] = "금은 0보다 낮거나 높아야 합니다.";
L["Paid for by"] = "지불자:";
L["Adjust gold in %s"] = "%s에서 금 조정";
L["You can't give AND receive gold from the same player at the same time"] = "같은 플레이어에게 동시에 골드를 주고 받을 수는 없습니다.";
L["All cuts were mailed!"] = "모든컷은 메일로 보냈습니다!";
L["Disable for disenchanted"] = "환멸을 느낀 경우 비활성화";
L["Disable in combat"] = "전투 중 비활성화";
L["Auctions"] = "경매";
L["Created by"] = "작성자:";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333%s에 의해 삭제됨
원인]];
L["\n|c00%s%sg added to pot by %s\nNote: %s"] = [[
|c00%s%sg을(를) %s님이 냄비에 추가했습니다
노트]];
L["\n%s paid |c00%s%sg for\n%s"] = [[
%s이(가) 지불함 |c00%s%sg
%에스]];
L["Won by"] = "승리자";
L["Set paid amount (read left)"] = "지불 금액 설정(왼쪽 읽기)";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul은 거래된 금을 자동으로 추적합니다. 플레이어가 돈을 지불하는 한
그들이 구매한 제품에 대해서는 이 필드가 필요하지 않습니다.

'결제 금액'은 구매자가 이미 거래한 골드 금액을 의미합니다.
이는 품목의 실제 가격을 변경하지 않습니다!

경고: 플레이어가 지불하겠다고 약속한 경우에만 여기에 값을 설정하세요.
레이드 외에서나 알트/메일 등에서 골드를 거래할 수 있어요!


]];
L["GDKP Price:"] = "GDKP 가격:";
L["Award %s to %s for %s?"] = "%s에 대해 %s에게 %s을(를) 부여하시겠습니까?";
L["Auto Bid"] = "자동 입찰";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "최대 입찰가는 얼마입니까? (최소 %s|c00FFF569g)";
L["Bid denied!"] = "입찰이 거부되었습니다!";
L["Min bid: %sg   Increment: %sg"] = "최소 입찰가: %sg 증분: %sg";
L["(max %sg)"] = "(최대 %sg)";
L["New bid"] = "새로운 입찰";
L["Stop Auto Bid"] = "자동 입찰 중지";
L["Top bid: %s by %s"] = "최고 입찰가: %s by %s";
L["Top bid: %s by you"] = "최고 입찰가: 귀하가 %s";
L["Create a new GDKP session"] = "새 GDKP 세션 만들기";
L["Management Cut %"] = "관리 삭감 %";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Management Cut은 비어 있거나 0에서 99 사이여야 합니다(% 기호 없음!).";
L["Choose a session type!"] = "세션 유형을 선택하세요!";
L["Switch to this session"] = "이 세션으로 전환";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFF다중 경매를 사용하면 한 번에 여러 항목에 대한 입찰을 시작하여 작업 속도를 높일 수 있습니다!
시작하려면 이 세션을 만든 후 지침을 따르세요.

|c00A79EFFSSingle-Auction을 사용하면 대신 단일 품목을 경매하거나 대기열을 사용할 수 있습니다.

|c00A79EFF다중 경매를 선택하면 삭제된 항목이 대기열에 추가되지 않습니다.
|c00A79EFFMulti-Auction과 |c00A79EFFSSingle-Auction 및 대기열을 혼합할 수 있지만 사용하지 않는 것이 좋습니다.

]];
L["Auction type (|c00A79EFFi for more info)"] = "경매 유형(자세한 내용은 |c00A79EFFi 참조)";
L["Multi-Auction"] = "다중 경매";
L["Single-Auction"] = "단일 경매";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "세션이 생성되었습니다. 게임이 충돌할 경우를 대비하여 올바르게 저장되도록 /reload를 권장합니다!";
L["Add Raider"] = "레이더 추가";
L["adjust [g]"] = "조정 [g]";
L["adjust [%]"] = "조정하다 [%]";
L["Announce the base cut in group chat"] = "그룹채팅에서 베이스컷 알리기";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "모든 플레이어와 계산을 재설정하시겠습니까? 참고: 더 이상 공격대에 참여하지 않는 모든 플레이어는 목록에서 제거됩니다!";
L["Delete Raider"] = "레이더 삭제";
L["Edit Raider"] = "레이더 편집";
L["Lock and Pay"] = "잠금 및 지불";
L["Manage gold trades"] = "금 거래 관리";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

Mutator를 사용하면 플레이어에게 금을 더 많거나 적게 줄 수 있습니다.
예: 탱크에 2%의 추가 혜택을 주는 것은 돌연변이의 목적입니다!

참고: 여기서 mutator를 편집하거나 삭제하면 이 세션에서만 변경됩니다.

]];
L["Not in the raid"] = "레이드에서는 안됨";
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
L["%s Raiders | %s With cut | Total payout: %sg"] = "%s 레이더 | %s 컷 있음 | 총 지불금: %sg";
L["Nothing to import, double check your CSV"] = "가져올 항목이 없습니다. CSV를 다시 확인하세요.";
L["Missing gold for player %s"] = "플레이어 %s의 골드가 누락되었습니다.";
L["Missing header, note: it's case-sensitive!"] = "헤더가 누락되었습니다. 참고: 대소문자를 구분합니다!";
L["Missing player name"] = "플레이어 이름이 누락되었습니다.";
L["Delete bid. Auction must be stopped first!"] = "입찰을 삭제하세요. 경매를 먼저 중단해야 합니다!";
L["Add a raider to this session"] = "이 세션에 침입자를 추가하세요";
L["Custom (create your own format)"] = "사용자 정의(자신만의 형식 만들기)";
L["Detailed (JSON)"] = "상세(JSON)";
L["Share (can be imported by other players)"] = "공유(다른 플레이어가 가져올 수 있음)";
L["Your custom format"] = "사용자 정의 형식";
L["Your custom header"] = "맞춤 헤더";
L["Custom (create your own format)"] = "사용자 정의(자신만의 형식 만들기)";
L["@PLAYER,@CUT"] = "@PLAYER,@CUT";
L["Player,Cut"] = "플레이어, 컷";
L["date/time at which the session was locked"] = "세션이 잠긴 날짜/시간";
L["total gold given to the player"] = "플레이어에게 주어진 총 골드";
L["gold mailed to the player"] = "플레이어에게 골드 우편 발송";
L["total gold received from the player"] = "플레이어로부터 받은 총 골드";
L["date/time at which the first item was awarded"] = "첫 번째 항목이 수여된 날짜/시간";
L["gold traded to the player"] = "플레이어에게 금이 거래되었습니다.";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "아이템,플레이어,골드,와우헤드링크";
L["Date/time at which the first item was awarded"] = "첫 번째 항목이 수여된 날짜/시간";
L["The title of the GDKP session"] = "GDKP 세션 제목";
L["Include disenchanted items"] = "마력 추출된 아이템 포함";
L["Pot changed"] = "냄비가 바뀌었다";
L["Gold Trades"] = "금 거래";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "확실합니까? 앞으로 나올 항목을 보거나 입찰할 수 없습니다!";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! 경고 !!|r

연결된 영역에 있고 플레이어 이름을 가져오는 중입니다.
예를 들어 영역 접미사 '%s'입니다. 이로 인해 전송이 발생할 수 있습니다.
잘못된 플레이어에게 메일을 자르고 잘라냅니다.

연결된 영역에 있을 때는 항상 플레이어의 영역 이름을 포함하도록 노력하세요!

계속 가져오시겠습니까?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "이렇게 하면 잘라내기 창에 대한 모든 변경 사항이 무시됩니다. 계속하시겠습니까?";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Google 시트처럼 자신의 계산에서 선수 컷을 가져올 수 있습니다. 소프트레스 GDKP 등

형식은 다음과 같습니다(|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333플레이어,골드|c00967FD2
플레이어1,4000
플레이어2,4125
플레이어3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
GDKP 최소 가격 및 증분을 가져옵니다.

형식은 다음과 같습니다. 항목 ID + 최소 또는 증분이 필요합니다. (|c00BE3333헤더가 필요합니다!!):

|c00BE3333항목ID,최소,증분|c00967FD2
18608,4000,500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "기존 가격 설정을 삭제하시겠습니까? 모든 가격 데이터를 삭제하려면 예를 클릭하고, 여기에 제공한 데이터로 기존 가격 데이터를 재정의하려면 아니요를 클릭하세요.";
L["Import GDKP Session"] = "GDKP 세션 가져오기";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "여기에서 GDKP 세션을 가져오고 계속할 수 있습니다. 누군가로부터 GDKP 세션을 얻으려면 |c00FFF569/gdkp에서 '공유(다른 플레이어가 가져올 수 있음)' 형식을 선택하여 내보내야 합니다.";
L["You're about to import a GDKP session created by %s, are you sure?"] = "%s이(가) 생성한 GDKP 세션을 가져오려고 합니다. 계속하시겠습니까?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "%s이(가) 만든 GDKP 세션이 이미 존재하는 것 같습니다. 무시하시겠습니까?";
L["Invalid data provided for GDKP extension!"] = "GDKP 확장에 잘못된 데이터가 제공되었습니다!";
L["Invalid data provided for GDKP reschedule!"] = "GDKP 일정 변경에 잘못된 데이터가 제공되었습니다!";
L["Invalid data provided for GDKP shortening!"] = "GDKP 단축에 잘못된 데이터가 제공되었습니다!";
L["Invalid data provided for GDKP auction start!"] = "GDKP 경매 시작에 잘못된 데이터가 제공되었습니다!";
L["Invalid number provided for 'paid'"] = "'유료'에 잘못된 번호가 제공되었습니다.";
L["Invalid time provided in Auction:reschedule"] = "경매에 잘못된 시간이 제공되었습니다:일정 변경";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP 데이터(%sx 판매됨)
마지막 판매 기간: %s
평균 가격: %s
최소 입찰가: %s
증분: %s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "잔액: |c0092FF000 ? 당신은 정사각형입니다! | |c00BE333330 ? 당신은 %s 30g을 빚지고 있습니다 | |c00F7922E50 ? %s님이 당신에게 50g을 빚지고 있습니다";
L["Gold mailed to you by %s"] = "%s님이 금을 우편으로 보냈습니다.";
L["Gold paid to %s"] = "%s에게 골드 지급";
L["Gold received from %s"] = "%s로부터 금을 받았습니다.";
L["Gold %s by"] = "골드 %s 님"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "총 팟: %sg | 관리 절단: %sg(%s%%) | 배포: %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s | 작성자: %s%s | |c00967FD2%s에서";
L["The GDKP Session is not available or locked"] = "GDKP 세션을 사용할 수 없거나 잠겨 있습니다.";
L["Mail All"] = "모두 메일 보내기";
L["No bids on Legendary+ item detected, continue manually!"] = "Legendary+ 항목에 대한 입찰이 감지되지 않았습니다. 수동으로 계속하세요!";
L["Missing content in Auction:start"] = "경매에 콘텐츠가 없습니다:시작";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

다중 경매(또는 일괄 경매)를 사용하면 원하는 만큼 많은 품목을 한 번에 경매할 수 있습니다!
이를 통해 습격의 밤 속도가 엄청나게 빨라지고 침입자에게 원활한 경험이 제공됩니다.

아직 인벤토리에 있는 모든 거래 가능한 아이템은 '인벤토리에서 채우기'를 통해 자동으로 경매될 수 있습니다.
한번 시도해 보세요!

|c00808080단 하나의 단점이 있습니다. 사람들이 일괄 경매에 참여하려면 침입자에게 Gargul이 필요하다는 것입니다!

]];
L["You need to have an active (unlocked) GDKP session!"] = "활성(잠금 해제된) GDKP 세션이 있어야 합니다!";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "이 창이 열린 상태에서 %s개의 항목을 목록에 추가하거나 아래 '인벤토리에서 채우기'를 클릭하세요."; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "단 몇 초 만에 저격 방지";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "저격 방지 값은 0(비어 있음) 또는 >=5여야 합니다.";
L["Go back to the item selector"] = "항목 선택기로 돌아가기";
L["Remove all items from the list"] = "목록에서 모든 항목 제거";
L["Fill from inventory"] = "재고에서 채우기";
L["Add tradeable items from your inventory to the list"] = "인벤토리의 거래 가능 아이템을 목록에 추가하세요.";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
여기에서 다중 경매 세션에 포함할 품목을 결정합니다.

목록에 아직 거래할 수 있는 아이템을 추가하려면 아래의 |c00A79EFFF인벤토리 채우기 버튼을 사용하세요.
이 창을 지우고 다시 열 때마다 마지막 채우기 설정이 자동으로 항목을 추가하는 데 사용됩니다.

|c00A79EFF%s 항목을 목록에 수동으로 추가하려면
]];
L["Next step: check raider's add-on version for compatibility"] = "다음 단계: Raider의 추가 기능 버전의 호환성을 확인하세요.";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "모든 사람이 Gargul을 사용하고 있는 것은 아닙니다. 경매를 시작하시겠습니까?";
L["Select at least one item for your auction"] = "경매 항목을 하나 이상 선택하세요.";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Gargul이 오래되었습니다. 문제를 방지하려면 세션을 시작하기 전에 업데이트하는 것이 좋습니다!";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "모든 사람이 최신 상태를 유지하는 것은 아닙니다. 문제가 발생하면 침입자에게 업데이트를 요청하세요!";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "활성 다중 경매가 있습니다. 여기에 추가하는 항목은 기존 세션에 추가됩니다. 중복상품에 주의하세요!";
L["Search name or iLVL"] = "이름 또는 iLVL 검색";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "항목 이름과 iLVL을 지원합니다. '252', '<252' 등";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "활성 GDKP 세션: |c00967FD2%s | 작성자: %s%s | |c00967FD2%s에서";
L["Auction time in seconds"] = "경매 시간(초)";
L["The auction time in seconds needs to be >= 10"] = "초 단위의 경매 시간은 >= 10이어야 합니다.";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "GDKP 입찰 세션 중에 떠났습니다. 이를 재개하려면 판매되지 않은 항목에 대해 새로운 입찰 시간(초)을 제공해야 합니다.";
L["With this window open, %s items to add them to the list"] = "이 창이 열려 있으면 %s개 항목을 목록에 추가할 수 있습니다.";
L["Click the cogwheel icon to manage an auction"] = "경매를 관리하려면 톱니바퀴 아이콘을 클릭하세요.";
L["You're already the top bidder on %s"] = "귀하는 이미 %s의 최고 입찰자입니다.";
L["\nBid |c00%s%sg\nBy %s"] = [[
입찰 |c00%s%sg
작성자: %s]];
L["\n|c00%sCLOSED\nNo bids"] = [[
|c00%s닫음
입찰 없음]];
L["\nMinimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
최소: |c00%s%sg
증분: |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "항목: %s - 총 판매 수: %sg - 내가 약속한 항목: %sg";
L["\nItems with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
입찰 항목: %s/%s
총 판매 수: %s
내가 구입함: %s
총 입찰가(판매된 금액은 포함되지 않음): %s
내가 입찰함(판매된 항목은 포함되지 않음): %s
]];
L["\n|c00%sSOLD to\n%s for |c00%s%sg"] = [[
|c00%s판매됨
|c00%s%sg에 대한 %s]];
L["\nBid |c00%s%sg\nBy |c0092FF00YOU!"] = [[
입찰 |c00%s%sg
작성자: c0092FF00YOU!]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "%s에 대한 자동 입찰을 중지할 수 없습니다. 다시 시도하거나 /reload하세요!";
L["Auto bid up to a maximum of %sg"] = "최대 %sg까지 자동 입찰";
L["Auto bid up to the bid you fill in on the left"] = "왼쪽에 입력한 입찰가까지 자동 입찰";
L["Stop your auto bid (%sg)"] = "자동 입찰 중지(%sg)";
L["Bid on %s could not be confirmed"] = "%s에 대한 입찰을 확인할 수 없습니다.";
L["Invalid bid or bid is too low! The minimum is %sg"] = "입찰가가 잘못되었거나 입찰가가 너무 낮습니다. 최소값은 %sg입니다.";
L["You need to wait two seconds between bids on the same item"] = "동일한 항목에 대한 입찰 사이에 2초를 기다려야 합니다.";
L["Clear bids"] = "입찰가 지우기";
L["Remove all bids from the auction"] = "경매에서 모든 입찰을 제거합니다.";
L["Close all"] = "모두 닫기";
L["Close ALL auctions?"] = "모든 경매를 종료하시겠습니까?";
L["\nClose ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!\n"] = [[
모든 경매 종료

활성 입찰이 있는 경매는 판매되며 새 입찰을 받을 수 없습니다!
]];
L["Close Auction"] = "경매 종료";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "경매를 종료합니다. 플레이어는 더 이상 입찰할 수 없지만 가장 높은 입찰은 계속 활성화됩니다.";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "입찰 세부정보를 포함하여 경매에서 항목을 제거합니다. 이 작업은 취소할 수 없습니다!";
L["Disenchant all finished but unsold items?"] = "완성되었으나 팔리지 않은 아이템을 모두 추출하시겠습니까?";
L["\nDisenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session\n"] = [[
팔리지 않은 아이템을 추출하세요

이렇게 하면 판매되지 않은 모든 항목이 마법 해제된 것으로 표시되며 새로운 다중 경매 세션에 표시되지 않습니다.
]];
L["Favorite this item"] = "이 항목을 즐겨찾기에 추가";
L["Give a final call timer of how many seconds?"] = "최종 통화 타이머를 몇 초로 설정하시겠습니까?";
L["The minimum amount of seconds is 5"] = "최소 시간(초)은 5입니다.";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "(보통 더 짧은) 입찰 타이머를 제공하여 이 경매에 대한 최종 호출을 시작합니다.";
L["Close ALL auctions and wrap up this multi-auction session?"] = "모든 경매를 종료하고 다중 경매 세션을 마무리하시겠습니까?";
L["\nFinish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!\n"] = [[
다중 경매 세션 완료

그러면 모든 경매가 종료되고 채팅에 총 팟이 표시됩니다.
활성 입찰이 있는 경매는 판매되며 새 입찰을 받을 수 없습니다!
]];
L["Hide inactive"] = "비활성 숨기기";
L["Hide unusable"] = "사용할 수 없는 숨기기";
L["Show/Hide finished auctions"] = "완료된 경매 표시/숨기기";
L["Manage Auction"] = "경매 관리";
L["Bid the minimum required amount"] = "최소 요구 금액으로 입찰하세요";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "입찰 창이 닫혔습니다. 다시 열려면 |c00A79EFF/gl 입찰을 사용하세요!";
L["Announce sales in chat"] = "채팅으로 판매 공지";
L["Play sound when outbid"] = "입찰가 초과 시 소리 재생";
L["More sound options..."] = "더 많은 사운드 옵션...";
L["Show all"] = "모두 보이기";
L["Show favorites"] = "즐겨찾기 표시";
L["Show inactive"] = "비활성 표시";
L["Show unusable"] = "사용할 수 없음 표시";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "이 품목은 판매되었습니다. 변경하려면 원장(|c00%s/gdkp)을 사용하세요!";
L["Terminate"] = "끝내다";
L["Remove all bidsl bids and close all auctions?"] = "모든 입찰가를 삭제하고 모든 경매를 종료하시겠습니까?";
L["\nTerminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!\n"] = [[
다중 경매 세션 종료

아직 판매되지 않은 품목에 대한 모든 입찰이 삭제되고 모든 경매가 종료됩니다!
]];
L["Hover over any of the buttons below for more information"] = "자세한 내용을 보려면 아래 버튼 위로 마우스를 가져가세요.";
L["Show/Hide items you can't use"] = "사용할 수 없는 항목 표시/숨기기";
L["Invalid data provided for GDKP auction start!"] = "GDKP 경매 시작에 잘못된 데이터가 제공되었습니다!";
L["%s bought %s for %sg"] = "%s는 %s을(를) %sg에 구입했습니다.";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "전리품 마스터(%s)가 오래되었습니다. 이로 인해 입찰이 실패할 수 있습니다!";
L["You were outbid!"] = "당신은 입찰가가 높았어요!";
L["Mutators"] = "돌연변이";
L["Add Mutator"] = "돌연변이 추가";
L["Auto apply to"] = "자동 적용 대상";
L["Create a new GDKP mutator"] = "새로운 GDKP 뮤테이터 생성";
L["Delete. Hold shift to bypass confirmation"] = "삭제. 확인을 우회하려면 Shift를 누르세요.";
L["Edit mutator"] = "돌연변이 편집";
L["Flat gold rate [example: 250]"] = "균일 금율 [예: 250]";
L["The flat rate needs to be a number"] = "정액 요금은 숫자여야 합니다.";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
예:
|c00967FD2SELF,RL,힐러]];
L["You can automatically apply this mutator to raiders using keywords:"] = "키워드를 사용하여 이 돌연변이원을 침입자에게 자동으로 적용할 수 있습니다.";
L["Name [example: Tanks]"] = "이름 [예: 탱크]";
L["Mutator names can not contains dots (.)"] = "Mutator 이름에는 점(.)이 포함될 수 없습니다.";
L["Percentage [example: 10]"] = "백분율 [예: 10]";
L["The percentage needs to be a number"] = "백분율은 숫자여야 합니다.";
L["Store for future sessions"] = "향후 세션을 위해 저장";
L["Unknown mutator: %s"] = "알 수 없는 돌연변이자: %s";
L["User '%s' is not allowed to start auctions"] = "사용자 '%s'은(는) 경매를 시작할 수 없습니다.";
L["User '%s' is not allowed to stop auctions"] = "사용자 '%s'은(는) 경매를 중지할 수 없습니다.";
L["User '%s' is not allowed to stop auction: auction invalid"] = "사용자 '%s'은(는) 경매를 중지할 수 없습니다. 경매가 유효하지 않습니다.";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "분배할 골드가 충분하지 않습니다. 이상한 삭감 계산이 예상됩니다!";
L["No bids!"] = "입찰이 없습니다!";
L["You were outbid!"] = "당신은 입찰가가 높았어요!";
L["(active)"] = "(활동적인)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
골드를 조정하려면 리드 또는 마스터 전리품이 필요합니다.
잠긴/삭제된 세션에서는 골드를 조정할 수 없습니다.]];
L["Add/Remove gold"] = "금 추가/제거";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s 유급의 |c00%s%s ~을 위한
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333%s에 의해 삭제됨
원인]];
L["(deleted)"] = "(삭제됨)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
항목을 삭제하려면 리드 또는 마스터 전리품이 필요합니다.
잠긴/삭제된 세션에서는 항목을 삭제할 수 없습니다.]];
L["Provide a reason for deleting this entry"] = "이 항목을 삭제하는 이유를 입력하세요.";
L["Delete. Hold shift to bypass note"] = "삭제. Shift 키를 누르고 있으면 메모를 무시할 수 있습니다.";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "경매가 연결된 세션은 48시간 후에 삭제됩니다.";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
항목을 편집하려면 리드 또는 마스터 전리품이 필요합니다.
삭제된 항목이나 잠긴/삭제된 세션의 항목은 편집할 수 없습니다.]];
L["Export a session so others can view session details or even replace you as a loot master"] = "다른 사람들이 세션 세부 정보를 보거나 귀하를 전리품 마스터로 교체할 수 있도록 세션을 내보냅니다.";
L["Import a session from another player or account"] = "다른 플레이어나 계정에서 세션 가져오기";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
원장의 전체 개요를 표시합니다.
스크린샷 목적에 이상적입니다!]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "세션을 잠그면 잠금을 해제할 때까지 항목을 경매하거나 다른 내용을 변경할 수 없습니다. 그렇죠?";
L["Lock or unlock the session"] = "세션 잠금 또는 잠금 해제";
L["Lock the session for payout"] = "지불을 위해 세션을 잠급니다.";
L["Multi-auction: auction multiple items at once!"] = "다중 경매: 여러 항목을 한 번에 경매합니다!";
L["added to"] = "에 추가됨";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s 화분 by %s
노트]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "에서 제거됨";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
냄비: %s
관리 절단(%s%%): %sg
플레이어당 컷(1/%s): %sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
항목을 복원하려면 리드 또는 마스터 전리품이 필요합니다.
잠긴/삭제된 세션의 항목은 복원할 수 없습니다.]];
L["By %s%s | On |c00%s%s%s"] = "작성자: %s%s | |c00%s%s%s에"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "팟이나 컷을 잠금 해제하고 변경하는 것은 매우 지저분할 수 있습니다. 특히 이미 지불금을 지불한 경우에는 더욱 그렇습니다. 확실합니까?";
L["Unlock the session"] = "세션 잠금 해제";
L["No active GDKP session detected or session is not locked for payout!"] = "활성 GDKP 세션이 감지되지 않거나 지급을 위해 세션이 잠겨 있지 않습니다!";
L["Increment or minimum can't be lower than .0001!"] = "증분 또는 최소값은 .0001보다 낮을 수 없습니다!";
L["Invalid 'Increment' provided for item ID '%s'"] = "항목 ID '%s'에 잘못된 '증분'이 제공되었습니다.";
L["Invalid 'Minimum' provided for item ID '%s'"] = "항목 ID '%s'에 잘못된 '최소'가 제공되었습니다.";
L["Either minimum or increment is required for item ID: %s"] = "항목 ID: %s에는 최소값 또는 증분값이 필요합니다.";
L["Missing header, note: it's case-sensitive!"] = "헤더가 누락되었습니다. 참고: 대소문자를 구분합니다!";
L["Successfully imported data for %s items"] = "%s 항목에 대한 데이터를 성공적으로 가져왔습니다.";
L["Unknown item ID: %s"] = "알 수 없는 항목 ID: %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s 가방, 전리품 창 또는 채팅 링크에 있는 항목을 이 경매 대기열에 추가할 수 있습니다.
현재 경매가 완료되면 대기열에 있는 항목이 자동으로 경매에 부쳐집니다. 이를 방지하려면 '%s' 버튼을 클릭하세요.

Gargul이 자동으로 경매를 낙찰하거나 마력을 해제하도록 하시겠습니까? 왼쪽에 있는 설정 휠을 열어보세요!

|c00FFF569알고 계셨나요?
드래그 앤 드롭으로 항목을 이동할 수 있습니다.
|c00A79EFF/reload를 수행하더라도 항목은 기억됩니다.
대기 중인 항목은 Gargul을 보유한 침입자에게 자동으로 표시되므로 사전 입찰이 가능합니다.
Gargul은 자동 약탈도 처리할 수 있습니다. |c00A79EFF/gl pm으로 확인해 보세요.
]];
L["Hide unusable items"] = "사용할 수 없는 항목 숨기기";
L["GDKP Session"] = "GDKP 세션";
L["Editing %s"] = "%s 편집 중";
L["Show upcoming items"] = "예정된 항목 표시";
L["Stop the auction first!"] = "먼저 경매를 중단하세요!";
L["%s owes you %s"] = "%s이(가) 당신에게 빚을 졌습니다 %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP 세션
플레이어가 소비한 금액: %s
주어진: %s
받았다: %s
플레이어 컷: %s

%s
]];
L["Exclude from GDKP"] = "GDKP에서 제외";
L["Gold traded will not be added to amount given or received"] = "거래된 금은 주고받는 금액에 추가되지 않습니다.";
L["Gold |c00967FD2given to %s"] = "금 |c00967FD2%s에게 주어졌습니다.";
L["Unable to add %s to the trade window. Try adding it manually!"] = "거래 창에 %s을(를) 추가할 수 없습니다. 수동으로 추가해보세요!";
L["You don't have enough money to pay %s"] = "%s에 지불할 돈이 부족합니다.";
L["To give: %s"] = "주실 분: %s";
L["To receive: %s"] = "수신 대상: %s";
L["Gold |c00967FD2received from %s"] = "금 |c00967FD2%s에게서 받았습니다.";
L["Check out Multi Auctions!"] = "다중 경매를 확인해보세요!";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "Gargul GDKP를 빠르게 시작하려면 아래 단계를 따르세요!";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "아래 |c00FFF569활성화 버튼을 클릭하여 이 세션을 활성화하십시오!";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s 단일 항목을 경매하거나 대기열에 추가할 항목"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
유용한 명령:
- |c00FFF569/gdkp 이 창을 엽니다.
- |c00FFF569/gl ma 다중 경매 창 열기
- |c00FFF569/gl au 단일 항목 경매인/대기열 열기
- |c00FFF569/gl pm 자동 약탈 설정

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "모든 것이 순조롭게 진행되었다면 여기에서 새로 경매된 품목을 볼 수 있습니다!";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "한 번에 여러 품목을 경매하고 싶으십니까? |c00FFF569/gl ma (또는 |c00FFF569/gl 다중 경매)를 실행하거나 이 창 오른쪽 상단에 있는 다중 경매 아이콘을 클릭하세요!";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "첫 번째 GDKP 세션을 생성하려면 아래의 |c00FFF569New 버튼을 클릭하세요. 생성되면 왼쪽에 표시됩니다.";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "아이템을 판매할 준비가 되었습니다! |c00BE3333첫 번째 GDKP 레이드를 시작하기 전에 아래의 모든 단계를 주의 깊게 읽고 직접 테스트해 보세요(레이드에 참가할 필요 없음)!";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "아무도 입찰하지 않고 품목을 판매하고 싶으십니까? |c00FFF569%s 항목에 대해 우승자를 선택하고 가격을 설정하세요!";
L["Getting started"] = "시작하기";
L["Unknown itemID in Auction:create: %s"] = "경매에서 알 수 없는 항목 ID:생성: %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "경매에서 알 수 없는 sessionIdentifier:create: %s";
L["You owe %s %s"] = "%s %s 빚을 졌습니다.";
L["Given"] = "주어진";
L["g"] = "g";
L["Group"] = "그룹";
L["Group Manager"] = "그룹 관리자";
L["Download on CurseForge"] = "CurseForge에서 다운로드";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "정지";
L["Header"] = "머리글";
L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"] = "|c00%sGargul v%s 작성자: Zhorax@Firemaw. 시작하려면 |c00%s/gl 또는 |c00%s/gargul을 입력하세요!";
L["Hide"] = "숨다";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Gargul GDKP 개인화에 대해 자세히 알아보려면 아래 URL을 방문하세요.";
L["Your logo here? Click for more info!"] = "여기에 로고가 있나요? 자세한 내용을 보려면 클릭하세요!";
L["Import"] = "수입";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "|c00A79EFF%s(c00A79EFF%s)에서 가져옴, |c00A79EFF%s(c00A79EFF%s)에서 업데이트됨";
L["What kind of data would you like to import?"] = "어떤 종류의 데이터를 가져오시겠습니까?";
L["Import of boosted roll data successful"] = "부스트 롤 데이터 가져오기 성공";
L["Inc"] = "Inc.";
L["Include previously awarded items"] = "이전에 수여된 항목 포함";
L["Include BOEs"] = "BOE 포함";
L["Include materials (like Abyss Crystals)"] = "재료 포함(Abyss Crystals 등)";
L["Increment"] = "증가";
L["Info"] = "정보";
L["Invalid data supplied"] = "잘못된 데이터가 제공되었습니다.";
L["Item"] = "안건";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "JSON 데이터를 디코딩할 수 없습니다. 추가 문자나 공백을 추가하지 않고 있는 그대로 복사하여 붙여넣으세요!";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
가르굴 아이템 단축키

롤아웃: |c00A79EFF%s
수상 내역: |c00A79EFF%s
마력 추출: |c00A79EFF%s


-- 이 창을 비활성화하려면 마우스 오른쪽 버튼을 클릭하세요 --
]];
L["Ledger"] = "원장";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "당신은 약탈의 달인이 되거나 보조/주도 역할을 맡아야 합니다!";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "참고: 설정에서 또는 |c00%s/gl 로케일을 통해 언제든지 로케일을 변경할 수 있습니다.";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul은 채팅 메시지를 영어로 게시합니다(기본값)
아래 드롭다운에서 다른 언어를 선택할 수 있습니다.

현재 채팅 언어는 '%s'입니다. 다른 언어를 활성화하면 /reload가 발생합니다!
]];
L["Choose a chat language for Gargul"] = "Gargul의 채팅 언어를 선택하세요";
L["ptBR"] = "ptBR"; -- Portuguese (Brazil)
L["ruRU"] = "루루"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "Gargul이 오작동할 가능성이 있는 하나 이상의 애드온이 설치되어 있습니다: %s";
L["Clear SoftRes"] = "SoftRes 지우기";
L["Clear TMB"] = "TMB 지우기";
L["/roll for MS or /roll 99 for OS"] = "MS의 경우 /roll, OS의 경우 /roll 99";
L["Import SoftRes"] = "SoftRes 가져오기";
L["Import TMB"] = "TMB 가져오기";
L["You were given the role of Master Looter"] = "당신은 Master Looter의 역할을 맡았습니다.";
L["Open this window automatically"] = "자동으로 이 창 열기";
L["Loot priorities cleared successfully"] = "전리품 우선순위가 성공적으로 지워졌습니다.";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "다음 형식(항목당 1줄)으로 prio CSV를 제공하세요: id or name > prio1,equalprio > prio2 > etc";
L["Loot priorities imported successfully"] = "전리품 우선순위를 성공적으로 가져왔습니다.";
L["Invalid data provided"] = "잘못된 데이터가 제공되었습니다.";
L["Invalid data provided in line: '%s': missing item id or priority"] = "다음 줄에 잘못된 데이터가 제공되었습니다: '%s': 항목 ID 또는 우선순위가 누락되었습니다.";
L["Attempting to process incoming loot priorities from %s"] = "%s에서 들어오는 전리품 우선순위를 처리하려고 시도 중입니다.";
L["Loot Prio"] = "전리품 프리오";
L["Mail"] = "우편";
L["Mailed"] = "우편으로 발송됨";
L["Mail cut to players"] = "플레이어에게 보내는 메일";
L["MS"] = "MS";
L["Maximize"] = "최대화";
L["Min"] = "최소";
L["Awarded loot history"] = "전리품 획득 내역";
L["GDKP Cuts"] = "GDKP 삭감";
L["Export data"] = "데이터 내보내기";
L["Open Gargul"] = "오픈 가르굴";
L["Import data"] = "데이터 가져오기";
L["GDKP Ledger"] = "GDKP 원장";
L["Multiauction"] = "다중경매";
L["Change settings in /gl minimap"] = "/gl 미니맵에서 설정 변경";
L["Minimize"] = "최소화";
L["Minimize on award"] = "수상 시 최소화";
L["Minimize on start"] = "시작 시 최소화";
L["Minimum"] = "최저한의";
L["Minimum item level"] = "최소 아이템 레벨";
L["Minimum Quality"] = "최소 품질";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "이동하다";
L["Multi-Auction"] = "다중 경매";
L["Name"] = "이름";
L["New"] = "새로운";
L["Next"] = "다음";
L["No"] = "아니요";
L["None"] = "없음";
L["Note"] = "메모";
L["Nothing"] = "아무것도 아님";
L["When no one bids do:"] = "아무도 입찰하지 않을 때:";
L["You don't have officer privileges"] = "당신은 장교 특권이 없습니다";
L["OS"] = "운영체제";
L["Ok"] = "좋아요";
L["Open"] = "열려 있는";
L["Open Auctioneer"] = "공개 경매";
L["Open Multi-Auction"] = "다중 경매 공개";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "%s을(를) 디스인챈트로 설정하시겠습니까?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "%s을(를) %s에게 보내시겠습니까? 이 마력 제거기를 제거하려면 /gl cd를 입력하세요!";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "디스인챈터가 설정되지 않았습니다. 설정하려면 /gl sd [mydisenchanter]를 사용하세요.";
L["Who is your disenchanter?"] = "당신의 환각자는 누구입니까?";
L["Paid"] = "유급의";
L["Pass"] = "통과하다";
L["%"] = "%";
L["Player"] = "플레이어";
L["Items won by %s:"] = "%s님이 획득한 아이템:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "플러스원";
L["Add a +1"] = "+1 추가";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "당신의 플러스원 데이터를 파티/공격대원 모두에게 방송하시겠습니까?";
L["Attempting to process incoming PlusOnes data from %s"] = "%s에서 들어오는 PlusOnes 데이터를 처리하려고 시도하는 중입니다.";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s는 모든 PlusOne 데이터를 삭제하려고 합니다. 모든 데이터를 삭제하시겠습니까?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "기존 PlusOne 데이터를 지우고 %s에서 브로드캐스트하는 새 데이터를 가져오시겠습니까?";
L["Are you sure you want to import new data broadcasted by %s?"] = "%s에서 브로드캐스트하는 새 데이터를 가져오시겠습니까?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "잘못된 데이터가 제공되었습니다. 내용이 필수 형식을 따르고 헤더 행이 포함되어 있지 않은지 확인하세요.";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
여기서는 CSV 또는 TSV 형식의 테이블에서 플러스원 데이터를 가져오거나 Google Docs 시트에서 붙여넣을 수 있습니다.

테이블에는 플레이어 이름과 포인트 금액이라는 두 개 이상의 열이 필요합니다. 추가 열은 무시됩니다.

다음은 예시 라인입니다:

푸바,240
]];
L["Automatically accept incoming broadcasts from %s"] = "%s에서 들어오는 브로드캐스트를 자동으로 수락합니다.";
L["Block all incoming +1 shared data"] = "모든 수신 +1 공유 데이터 차단";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
기존 PlusOne 데이터를 %s의 데이터로 업데이트하시겠습니까?

귀하의 최신 업데이트는 |c00A79EFF%s에 있었고, 해당 업데이트는 |c00A79EFF%s에 있었습니다.]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "냄비";
L["Price"] = "가격";
L["PL"] = "PL";
L["Common"] = "흔한";
L["Epic"] = "서사시";
L["Heirloom"] = "법정 상속 동산";
L["Legendary"] = "전설적인";
L["Poor"] = "가난한";
L["Rare"] = "희귀한";
L["Uncommon"] = "드문";
L["Queue"] = "대기줄";
L["Raiders"] = "레이더스";
L["Who's Missing"] = "누가 실종됐나요?";
L["Show missing player names"] = "누락된 플레이어 이름 표시";
L["Disband raid"] = "레이드 해산";
L["Disband your raid"] = "공격대를 해체하세요";
L["%s is listed twice on the roster!"] = "%s님이 명단에 두 번 등재되어 있습니다!";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "|c00FFF569Raid-Helper 내보내기('세로로 정렬된 그룹' 변형 사용) 또는 |c00FFF569Gargul 그룹 구성 CSV:";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
아래의 큰 편집 상자에서 명단을 제공하고 모든 사람을 초대하고 누락된 사람을 확인하고 그룹을 적용하고 탱크를 할당할 수 있습니다.

|c00FFF569와우헤드 공격대 구성 링크를 제공하실 수 있습니다:]];
L["Gargul Group Wiki"] = "가르굴 그룹 위키";
L["Visit the Gargul group wiki for more info on the raid group format"] = "공격대 그룹 형식에 대한 자세한 내용은 Gargul 그룹 위키를 방문하세요.";
L["The following players are not part of the roster: %s"] = "다음 플레이어는 명단에 포함되어 있지 않습니다: %s";
L["Invalid group data provided, check your format!"] = "잘못된 그룹 데이터가 제공되었습니다. 형식을 확인하세요!";
L["Invite"] = "초대하다";
L["Send invites to players on roster"] = "명단에 있는 플레이어에게 초대장 보내기";
L["Can't sort groups while %s is in combat!"] = "%s이(가) 전투 중인 동안에는 그룹을 정렬할 수 없습니다!"; -- %s holds a player name
L["You need to be in a raid!"] = "습격을 당해야 해요!";
L["No tanks defined"] = "정의된 탱크가 없습니다.";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "%s님을 위한 장소를 찾을 수 없습니다. 1개 그룹에 5명 이상을 배치하려고 하시나요?";
L["Kick unwanted players"] = "원치 않는 플레이어를 추방하세요";
L["Kick players that aren't on the roster"] = "명단에 없는 선수를 추방하세요.";
L["Something went wrong while moving %s"] = "%s을(를) 이동하는 동안 문제가 발생했습니다";
L["Finished applying raid roster"] = "레이드 명단 적용 완료";
L["Sorting groups"] = "그룹 정렬";
L["Apply Groups"] = "그룹 적용";
L["Sort groups based on roster"] = "명단을 기준으로 그룹 정렬";
L["Sorting is still in progress, wait a bit!"] = "아직 정렬이 진행 중입니다. 조금만 기다려주세요!";
L["All tanks are assigned"] = "모든 탱크가 할당되었습니다.";
L["Assign Tanks"] = "탱크 배정";
L["Wowhead Comp Tool"] = "와우헤드 합성 도구";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "아래 URL을 통해 와우헤드 구성 도구를 방문하실 수 있습니다. 구성 요소를 만든 후 여기에 붙여넣거나 Gargul 그룹 창의 큰 편집 필드에 붙여넣을 수 있습니다.";
L["Remove bid"] = "입찰 삭제";
L["Reset Settings"] = "재설정 설정";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "Gargul의 모든 설정을 재설정하시겠습니까? 이 작업은 취소할 수 없습니다!";
L["Reset Gargul UI"] = "가르굴 UI 재설정";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "Gargul의 모든 창 크기, 위치 및 배율을 재설정하시겠습니까? 이 작업은 취소할 수 없습니다!";
L["Restore"] = "복원하다";
L["Resume"] = "재개하다";
L[">"] = ">";
L["Roll"] = "롤";
L["Award %s to %s?"] = "%s을(를) %s에게 수여하시겠습니까?";
L["Close on award"] = "수상 마감";
L["Close on start"] = "시작 시 닫기";
L["Hold shift to bypass the award confirmation"] = "수상 확인을 우회하려면 교대근무를 보류하세요.";
L["Hold shift to show the award confirmation"] = "수상 확인을 표시하려면 교대 근무를 기다리세요.";
L["\nWarning: another identical roll was found which can point to a tie\n\n"] = [[
경고: 동점을 나타낼 수 있는 또 다른 동일한 굴림이 발견되었습니다.

]];
L["Invalid data provided for roll start!"] = "시작 롤에 잘못된 데이터가 제공되었습니다!";
L["(BR: %s)"] = "(BR: %s)";
L["(item given: yes)"] = "(주어진 아이템: 예)";
L["(item given: no)"] = "(주어진 아이템 : 아니오)";
L["(OS)"] = "(OS)";
L["NOTE"] = "메모";
L["Can't stop roll off, no roll off in progress"] = "출시를 중지할 수 없으며 진행 중인 출시가 없습니다.";
L["Pass"] = "통과하다";
L["rolls: %s"] = "롤: %s";
L["Open master looter window"] = "마스터 루터 창 열기";
L["Roll accepted!"] = "롤 승인됨!";
L["A roll is currently in progress"] = "현재 롤이 진행 중입니다.";
L["Prio [%s]"] = "우선 순위 [%s]";
L["SR [%sx]"] = "SR [%sx]";
L["Wish [%s]"] = "[%s] 소원";
L["You need to select a player first"] = "먼저 플레이어를 선택해야 합니다.";
L["TIMER (s)"] = "타이머(초)";
L["You can't use this item!"] = "이 아이템을 사용할 수 없습니다!";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "우승자의 이름이 고유하지 않습니다. %s 상을 주고 싶은 플레이어를 선택하세요.";
L["s"] = "에스";
L["Select / Disable all"] = "모두 선택 / 비활성화";
L["Session"] = "세션";
L["Settings"] = "설정";
L["Announce incoming bids"] = "들어오는 입찰 발표";
L["Announce pot after awarding item"] = "아이템 수여 후 냄비 발표";
L["Announce auction start"] = "경매 시작 알림";
L["Announce countdown in raid warning"] = "레이드 경고에서 카운트다운 알림";
L["Announce incoming bids in raid warning"] = "습격 경고를 통해 들어오는 입찰을 알립니다.";
L["Reset Gargul UI"] = "가르굴 UI 재설정";
L["Whisper bidder if bid is too low"] = "입찰가가 너무 낮으면 입찰자에게 귓속말을 보내세요.";
L["s"] = "s";
L["Skip"] = "건너뛰다";
L["Soft-Reserves"] = "소프트 리저브";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "당신의 소프트레스 데이터를 파티/레이드의 모든 사람에게 방송하시겠습니까?";
L["Couldn't process SoftRes data received from %s"] = "%s에서 받은 SoftRes 데이터를 처리할 수 없습니다.";
L["Are you sure you want to clear all existing soft-reserve data?"] = "기존의 모든 소프트 예약 데이터를 지우시겠습니까?";
L["Everyone filled out their soft-reserves"] = "모두가 소프트 리저브를 채웠습니다.";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
소프트 예약이 있기 때문에 하드 예약 정보를 사용할 수 없습니다.
제공된 항목은 Softres.it의 'Gargul 내보내기' 버튼을 사용하여 생성되지 않았습니다.]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "|c00A79EFF%s의 |c00A79EFF%s에서 가져옴";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "자동 이름 수정: '%s'의 SR이 이제 '%s'에 연결되었습니다.";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "시작하려면 먼저 Softres.it에 대한 공격대를 만들어야 합니다. 그런 다음 '애드온 내보내기'를 클릭하고 'Gargul'을 선택한 후 데이터를 복사하여 아래 양식에 붙여넣습니다.";
L["Invalid soft-reserve data provided"] = "잘못된 소프트 예약 데이터가 제공되었습니다.";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "잘못된 데이터가 제공되었습니다. Softres.it에서 'Gargul 내보내기' 버튼을 클릭하고 여기에 전체 내용을 붙여넣으세요.";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "제공된 PlusOne 값이 이미 존재하는 값과 충돌합니다. 이전 PlusOne 값을 교체하시겠습니까?";
L["The following players did not reserve anything:"] = "다음 플레이어는 아무것도 예약하지 않았습니다.";
L["Soft-reserves imported successfully"] = "소프트 예약을 성공적으로 가져왔습니다.";
L["Import successful!"] = "가져오기 성공!";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "SoftRes Weakaura 및 CSV 데이터는 더 이상 사용되지 않습니다. 대신 Gargul 내보내기를 사용하세요!";
L["Failed to connect to LootReserve, contact support (include message below)"] = "LootReserve에 연결하지 못했습니다. 지원팀에 문의하세요(아래 메시지 포함).";
L["%s (%sx)"] = "%s(%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "사용할 수 있는 Softres.it URL이 없습니다. Softres.it의 'Gargul 내보내기' 버튼을 사용하여 내보냈는지 확인하세요!";
L["Click here to see hard-reserve info"] = "하드 예약 정보를 보려면 여기를 클릭하세요.";
L["No items are hard-reserved"] = "하드 예약된 항목이 없습니다.";
L["No hard-reserve info available"] = "사용 가능한 하드 예약 정보가 없습니다.";
L["Post missing SRs"] = "누락된 SR 게시";
L["Post SR URL"] = "SR 게시 URL";
L["This player did not reserve anything!"] = "이 플레이어는 아무것도 예약하지 않았습니다!";
L["%s (%sx)"] = "%s(%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "%s에서 들어오는 SoftRes 데이터를 처리하려고 시도하는 중입니다.";
L["This item is hard-reserved"] = "이 항목은 예약되어 있습니다.";
L["For: %s"] = "대상: %s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 참고: %s";
L["Reserved by"] = "예약자";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "문제가 발생했습니다.";
L["Start"] = "시작";
L["Stop"] = "멈추다";
L["\\t is replaced by a tab"] = "\\t is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "시간";
L["Title"] = "제목";
L["TMB, DFT or PRIO3"] = "TMB, DFT 또는 PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "TMB 데이터를 파티/공격대원 모두에게 방송하시겠습니까? 주의: TMB 웹사이트의 권한에 관계없이 모든 사람이 귀하의 TMB 데이터를 볼 수 있습니다!";
L["Attempting to process incoming TMB data from %s"] = "%s에서 들어오는 TMB 데이터를 처리하려고 시도하는 중입니다.";
L["Are you sure you want to clear all plus one data?"] = "플러스원 데이터를 모두 삭제하시겠습니까?";
L["Clear Raider Data"] = "레이더 데이터 지우기";
L["Clear TMB data for all raiders?"] = "모든 침입자의 TMB 데이터를 삭제하시겠습니까?";
L["Auto-sharing enabled: %s"] = "자동 공유 활성화됨: %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "classicpr.io 실행에서 'Gargul 내보내기' 버튼을 클릭하고 내용을 복사하세요. 이후 아래 박스에 내용을 그대로 붙여넣고 '가져오기'를 클릭하세요. 그게 다야!";
L["Imported on ${date} at ${time}"] = "${date} ${time}에 가져옴";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "시트의 지침에 따라 DFT 데이터를 내보냅니다. 이후 아래 박스에 내용을 그대로 붙여넣고 '가져오기'를 클릭하세요. 그게 다야!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "제공된 CSV가 잘못되었습니다. 형식은 6948,player1,player2입니다.";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "잘못된 DFT 데이터가 제공되었습니다. 시트의 지침에 따라 DFT 데이터를 내보내고 여기에 내용을 그대로 붙여넣으세요.";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "잘못된 TMB 데이터가 제공되었습니다. Gargul 섹션에서 '다운로드' 버튼을 클릭하고 내용을 그대로 여기에 붙여넣으세요!";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "잘못된 TMB 또는 DFT 데이터가 제공되었습니다. 내보내기 내용을 그대로 여기에 붙여넣으세요!";
L["Priority notes available: %s"] = "사용 가능한 우선순위 메모: %s";
L["Number of items imported: %s"] = "가져온 항목 수: %s";
L["The following players have no %s entries:"] = "다음 플레이어에게는 %s 항목이 없습니다:"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "${source}와 함께 Gargul을 사용하는 방법";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "TMB 내보내기 내용을 그대로 아래 상자에 붙여넣고 '가져오기'를 클릭하세요.";
L["There's no one in your group to broadcast to"] = "그룹에 방송할 사람이 없습니다.";
L["TMB data synced"] = "TMB 데이터 동기화됨";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF 참고: |c00FFF569%s";
L["(OS)"] = "(OS)";
L["%s Prio List"] = "%s 우선 순위 목록"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF 계층: %s";
L["TMB Wish List"] = "TMB 위시리스트";
L["Show/Hide Dates"] = "날짜 표시/숨기기";
L["Show/Hide Queue"] = "대기열 표시/숨기기";
L["%s to award loot!"] = "%s님이 전리품을 드립니다!";
L["%s to roll out loot!"] = "%s 전리품을 출시하세요!";
L["Hide all awarded items"] = "수여된 모든 항목 숨기기";
L["Hide disenchanted items"] = "마력이 추출된 아이템 숨기기";
L["Hide items awarded to self"] = "자신에게 수여된 아이템 숨기기";
L["Announce Trade"] = "거래 발표";
L["Announce trade details to group or in /say when not in a group"] = "거래 내역을 그룹에 알리거나 그룹에 속하지 않을 때 /say에 알리세요.";
L["Tutorial"] = "지도 시간";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s 가방, 전리품 창 또는 채팅 링크에 있는 항목을 경매 대기열에 추가할 수 있습니다.
입찰 없이 상품을 직접 판매하고 싶으신가요? |c00A79EFF%s 사용

|c00A79EFF/gl 경매를 입력하여 %s 창을 직접 열 수 있습니다.

Gargul은 |c00FF0000ALL 금 거래를 추적합니다. 이번 GDKP 세션에 거래가 포함되는 것을 원하지 않으시나요? 거래 시 'GDKP에서 제외' 확인란을 선택하세요!

|c00FFF569알고 계셨나요?
획득한 아이템은 자동으로 거래창에 추가됩니다.
Gargul은 자동 약탈도 처리할 수 있습니다. |c00A79EFF/gl pm으로 확인해 보세요.
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
이 창에는 특정 날짜에 수여된 모든 항목이 표시됩니다(왼쪽에서 하나 이상의 날짜 선택).

항목에는 다음 태그가 포함될 수 있습니다.

|c00A79EFFOS: 오프스펙으로 수여됨
|c00A79EFFSR: 이 항목은 소프트 예약되었습니다.
|c00A79EFFWL: 이 항목은 위시리스트에 추가되었습니다(Thatsmybis)
|c00A79EFFPL: 이 항목은 우선적으로 등록되었습니다(Thatsmybis, DFT, prio3).
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
여기에 표시되는 항목은 마스터 루터의 GDKP 대기열에 있습니다.
해당 항목을 제거하고 입찰하고 사용할 수 없는 항목을 숨길 수 있습니다(왼쪽 상단 설정에서 '사용할 수 없는 항목 숨기기' 활성화).

창 크기를 조정하거나, 이동하거나, 최소화할 수 있습니다. 사용해 보세요!

전리품 마스터의 경우: 여기서 항목을 제거하면 실제 GDKP 대기열이 아닌 개인 대기열에서만 제거됩니다!
]];
L["Need more help?"] = "도움이 더 필요하신가요?";
L["Type"] = "유형"; -- As in type of roll or type of item
L["unknown"] = "알려지지 않은";
L["Unknown comm action '%s', make sure to update Gargul!"] = "알 수 없는 통신 작업 '%s', Gargul을 업데이트하세요!";
L["Unlock"] = "터놓다";
L["Update Gargul!"] = "가르굴을 업데이트하세요!";
L["v"] = "V";
L["Report"] = "보고서";
L["Report outdated results in group chat"] = "그룹 채팅에서 오래된 결과 신고";
L["Gargul status"] = "가르굴 상태";
L["Checking version ..."] = "버전 확인 중...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s: 플레이어가 최신 상태입니다.
|c00F7922Ev%s: 플레이어는 자신의 추가 기능을 업데이트해야 합니다.
|c00BE3333%s: 플레이어에 Gargul이 없거나 지원되지 않는 버전을 사용하고 있습니다.
|c00808080%s: 플레이어가 오프라인이거나 우리를 무시하고 있습니다!
|c0000FFFF%s: 해당 플레이어가 무시 목록에 있습니다!

]];
L["PLAYER IGNORED!"] = "플레이어가 무시되었습니다!";
L["Offline"] = "오프라인";
L["No response"] = "응답 없음";
L["No response:"] = "응답 없음:";
L["Offline:"] = "오프라인:";
L["Outdated:"] = "시대에 뒤쳐진:";
L["Up-to-date:"] = "최신 정보:";
L["Gargul is out of date and won't work until you update!"] = "Gargul은 최신 버전이 아니며 업데이트할 때까지 작동하지 않습니다!";
L["Invalid version string provided in Version:addRelease"] = "버전:addRelease에 잘못된 버전 문자열이 제공되었습니다.";
L["Update Gargul!"] = "가르굴을 업데이트하세요!";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul은 이제 |c00%sv%s로 업데이트되었습니다.";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "v|c00A79EFFv%s는 CurseForge/Wago에서 사용할 수 있습니다. 게임을 닫지 않고도 업데이트할 수 있습니다. /reload를 꼭 해주세요!";
L["Wait %s more seconds before you retry"] = "다시 시도하기 전에 %s초 더 기다리십시오.";
L["Window"] = "창문";
L["Gargul v%s"] = "가르굴 v%s";
L["Window Scale"] = "창 규모";
L["WL"] = "WL";
L["Yes"] = "예";
L["You disabled GDKP queues"] = "GDKP 대기열을 비활성화했습니다.";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "zlib로 데이터를 압축할 수 없습니다. https://discord.gg/D3mDhYPVzf를 통해 지원팀에 문의하세요.";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "zlib로 데이터 압축을 풀 수 없습니다. 추가 문자나 공백을 추가하지 않고 있는 그대로 복사하여 붙여넣으세요!";
