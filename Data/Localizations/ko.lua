--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "koKR") then return; end
]]
if (GetLocale() ~= "koKR") then return; end
local L = Gargul_L or {};

L.ABOUT = "에 대한";
L.ALL_SETTINGS = "모든 설정";
L.ANNOUNCE = "발표하다";
L.ANTISNIPE = "안티 스나이프";
L.ANTISNIPE_EXPLANATION = [[

Anti Snipe 값이 10이라는 것은
10초도 채 남지 않으면 타이머가 다시 10초로 재설정됩니다.

이 항목을 비워두거나 0으로 설정하여 Anti Snipe를 완전히 비활성화할 수 있습니다.
5 미만의 Anti Snipe 값은 지원되지 않습니다.

]];
L.ARE_YOU_SURE = "확실합니까?";
L.ASSIGN_GARGUL_INFO = [[
대신 Gargul을 사용하는 것을 잊지 마세요
나중에 전리품을 내보내고 싶다면


-- 이 창을 비활성화하려면 마우스 오른쪽 버튼을 클릭하세요 --]];
L.AUCTION = "경매";
L.AUCTIONEER = "경매인";
L.AUCTIONS = "경매";
L.AUTO = "자동";
L.AUTO_AWARD = "자동상";
L.AUTO_TRADE_OPTIONS = "자동거래";
L.AVAILABLE_PLACEHOLDER_VALUES = "사용 가능한 값:";
L.AWARD = "상";
L.AWARDED_TO = "수여 대상";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "가격: %s";
L.AWARDED_TOOLTIP_GIVEN = "주어진 : 예";
L.AWARDED_TOOLTIP_NOT_GIVEN = "주어진 : 아니오";
L.AWARDED_TOOLTIP_SECOND_BID = "두 번째 입찰: %s by %s";
L.AWARDED_YOU_WON = "당신이 이겼어요";
L.AWARD_CONFIRM = "%s을(를) %s에게 수여하시겠습니까?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "정말로 %s의 마법을 해제하시겠습니까? %s의 증가된 롤 포인트가 환불됩니다!";
L.AWARD_HEADER_IN_GROUP = "그룹에서";
L.AWARD_HISTORY = "수상 내역";
L.AWARD_NEW_WINNER_CONFIRMATION = "%s 대신 누구에게 가야 할까요?";
L.AWARD_PLAYER_CUSTOM_NAME = "여기에 플레이어 이름을 입력하세요.";
L.AWARD_PLAYER_SELECT_NAME = "또는 아래 중 하나를 선택하세요.";
L.AWARD_RANDOM_CONFIRM = "무작위 플레이어에게 %s 상을 주시겠습니까?";
L.AWARD_TOOLTIP_ADD_ITEM = "오른쪽 상자에 있는 항목을 드래그 앤 드롭하거나 Shift+클릭하세요.";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "마력 추출된 아이템:";
L.AWARD_TOOLTIP_GIVEN = "(제공: 예)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(주어진: 아니오)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(OS)";
L.AWARD_UNDO_BR_REFUND = "%s의 증가된 롤 포인트가 환불됩니다!";
L.AWARD_UNDO_CONFIRM = "%s이(가) %s에게 부여된 것을 실행 취소하시겠습니까?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "가방 검사 실패: 보고된 내용이 없습니다.";
L.BAGINSPECTOR_FINISHED = "검사완료";
L.BAGINSPECTOR_START = "점검 시작...";
L.BALANCE = "균형";
L.BASE = "베이스";
L.BASE64_DECODE_WARNING = "Base64로 데이터를 디코딩할 수 없습니다. 추가 문자나 공백을 추가하지 않고 있는 그대로 복사하여 붙여넣으세요!";
L.BID = "매기다";
L.BIDS = "입찰";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. 레이드 가입 시 자동으로 그룹 초대/정렬 가능! 아래를 클릭하거나 |c00A79EFF/gl gr을 사용하세요.";
L.BONUS_BOOSTED_ROLLS = "2. 단골이 되거나 더 많은 노력을 기울이는 플레이어에게 보상을 주세요! 아래를 클릭하거나 |c00A79EFF/gl br을 사용하세요.";
L.BONUS_FEATURE_EXPLANATION = "Gargul에는 여러분이 알지 못할 수도 있는 몇 가지 트릭이 있습니다. 멋져보세요!";
L.BONUS_PLUSONES = "3. Gargul에는 플러스원 추적 시스템이 포함되어 있습니다! 아래를 클릭하거나 |c00A79EFF/gl po를 사용하세요.";
L.BOOSTED_ROLLS = "부스트 롤";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
현재 공격대에 있는 모든 사람에게 몇 점을 추가합니까?

|c00BE3333부스트 롤 항목이 없는 사람이라도 모든 사람이 포인트를 얻을 수 있도록 하려면 먼저 '누락된 침입자 추가' 버튼을 사용하세요!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "포인트 값이 제공되지 않습니다!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "레이드에 포인트 추가";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "누락된 침입자 추가";
L.BOOSTED_ROLLS_ALIASES = "별칭";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "별칭 적용";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "부스트 롤 비용:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "부스트 롤 데이터를 파티/레이드의 모든 사람에게 방송하시겠습니까?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "방송할 것이 없습니다. 먼저 Boosted Rolls 데이터를 가져오세요!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "%s에서 받은 BoostedRolls 데이터를 처리할 수 없습니다.";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "%s에서 들어오는 BoostedRolls 데이터를 처리하려고 시도하는 중입니다.";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "모든 부스트 롤 데이터를 삭제하시겠습니까?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "%s을(를) 삭제하시겠습니까?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "기존 부스트 롤 데이터를 지우고 %s에서 방송하는 새 데이터를 가져오시겠습니까?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "잘못된 데이터가 제공되었습니다. 내용이 필수 형식을 따르고 헤더 행이 포함되어 있지 않은지 확인하세요.";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
여기서는 CSV 또는 TSV 형식의 테이블에서 부스트 롤 데이터와 별칭을 가져오거나 Google Docs 시트에서 붙여넣을 수 있습니다.

테이블에는 플레이어 이름과 포인트 금액이라는 두 개 이상의 열이 필요합니다. 추가 열은 선택 사항이며 플레이어의 별칭을 포함할 수 있습니다.
다음은 예시 라인입니다:

푸바,240,바푸]];
L.BOOSTED_ROLLS_POINTS = "포인트들";
L.BOOSTED_ROLLS_RESERVE = "예약하다";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
%s의 데이터로 기존 부스트 롤을 업데이트하시겠습니까?

귀하의 최신 업데이트는 |c00A79EFF%s에 있었고, 해당 업데이트는 |c00A79EFF%s에 있었습니다.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!보너스|!rb|!br";
L.BROADCAST = "방송";
L.BROADCASTING_NOTIFICATION = "방송...";
L.BROADCAST_DELAYED_BY_COMBAT = "현재 전투 중이므로 방송이 지연되고 있습니다.";
L.BROADCAST_FINISHED = "방송완료!";
L.BROADCAST_INC_AWARDED = "수여된 항목 포함";
L.BROADCAST_INC_DISENCHANTED = "마력 추출된 아이템 포함";
L.BROADCAST_INC_HIDDEN = "숨겨진 항목 포함";
L.BROADCAST_INC_TIME_LEFT = "남은 시간 포함";
L.BROADCAST_IN_PROGRESS_ERROR = "방송은 아직 진행 중";
L.BROADCAST_NO_DATA = "방송할 일이 없네";
L.BROADCAST_NUMBER_OF_ITEMS = "항목 수";
L.BROADCAST_PROGRESS = "방송 ${percentage}%";
L.BROADCAST_TARGET_PLAYER = "대상 플레이어(속삭임만)";
L.BROADCAST_TARGET_REQUIRED = "속삭임에는 대상 플레이어가 필요합니다";
L.BROADCAST_TRADE_TIME_LEFT = "남은 최대 거래 시간(분)";
L.BY = "~에 의해"; -- As in 'bid BY'
L.CANCEL = "취소";
L.CHANGELOG_CONTRIBUTE = "Discord에서 지원을 받거나 아이디어를 공유하세요";
L.CHANGELOG_ENABLE_LABEL = "변경 로그 활성화";
L.CHANGELOG_GETTING_STARTED = "Gargul을 사용하면 전리품을 매우 쉽게 나눠줄 수 있습니다. 시작하려면 아래 버튼을 클릭하세요!";
L.CHANGELOG_OPEN_GARGUL = "오픈 가르굴";
L.CHANGE_SCALE = "규모 조정";
L.CHANNEL = "채널";
L.CHANNEL_OFFICER = "장교";
L.CHANNEL_RAID_WARNING = "습격 경고";
L.CHANNEL_WHISPER = "속삭임";
L.CLASSICPRIO_ABBR = "심폐소생술";
L.CLEAR = "분명한"; -- As in clearing a window or data
L.CLOSE = "닫다";
L.CLOSE_ON_AWARD = "수상 마감";
L.CLOSE_ON_START = "시작 시 닫기";
L.COMMUNICATION = "의사소통";
L.COMM_PROGRESS = "%s/%s바이트를 보냈습니다.";
L.COPPER_INDICATOR = "c";
L.CUT = "자르다";
L.CUTS = "컷";
L.CUT_MAILBOX_CLOSED = "사서함이 닫혀 있으면 메일을 보낼 수 없습니다";
L.CUT_MAILS_FAILED = "다수의 메일 오류가 감지되어 컷 배포가 중단되었습니다.";
L.CUT_MAIL_BODY = "Gargul 제공: TMB, SoftRes, GDKP 및 자동 루팅을 지원하는 마스터 전리품 도구입니다!";
L.CUT_MAIL_EVEN = "%s의 금이 없습니다.";
L.CUT_MAIL_FAILED = "%s에 컷을 보내지 못했습니다.";
L.CUT_MAIL_GOLD_MISMATCH = "게임에 따라 메일이 전송되었지만 남은 GOLD가 일치하지 않습니다. 문제가 발생했나요?";
L.CUT_MAIL_HISTORY = "|c00967FD2%s에 대한 메일 기록";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "%s에 지불할 골드가 부족합니다.";
L.CUT_MAIL_IN_PROGRESS = "잠시만 기다려주세요. 아직 이전 메일을 처리하는 중입니다.";
L.CUT_MAIL_SUBJECT = "가르굴 GDKP: %sg";
L.CUT_SENT = "%sg을(를) %s로 보냈습니다.";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "삭제";
L.DETAILS = "세부";
L.DFT = "DFT";
L.DISABLE = "장애를 입히다";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "마력 추출";
L.EDIT = "편집하다";
L.ENABLE = "할 수 있게 하다";
L.EXPORT = "내보내다";
L.EXPORT_DELETE_ALL_CONFIRM = "전체 보상 내역 테이블을 삭제하시겠습니까? 이렇게 하면 모든 전리품 데이터가 삭제되며 취소할 수 없습니다!";
L.EXPORT_DELETE_DATE_CONFIRM = "%s에 대한 모든 데이터를 제거하시겠습니까? 이 취소 할 수 없습니다!";
L.EXPORT_READ_ONLY_NOTICE = [[
이것은 내보내기 기능일 뿐이므로 값을 편집할 필요가 없습니다. 값은 저장되지 않습니다!

]];
L.FILL = "채우다";
L.FINAL_CALL = "최종 호출";
L.FINISH = "마치다";
L.FORMAT = "체재";
L.GARGUL = "가르굴";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "이 버전의 월드 오브 워크래프트에서는 GDKP 공격대가 허용되지 않습니다.";
L.GDKP_ACTIVATED = "GDKP 액티브!";
L.GDKP_ADD_DROPS_TO_QUEUE = "대기열에 떨어진 전리품 추가";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "금(-금 제거용)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "누가 비용을 지불합니까?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "금은 0보다 낮거나 높아야 합니다.";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "지불자:";
L.GDKP_ADD_GOLD_TITLE = "%s에서 금 조정";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "같은 플레이어에게 동시에 골드를 주고 받을 수는 없습니다.";
L.GDKP_ALL_CUTS_MAILED = "모든컷은 메일로 보냈습니다!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "환멸을 느낀 경우 비활성화";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "전투 중 비활성화";
L.GDKP_AUCTIONS = "경매";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "작성자:";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333%s에 의해 삭제됨
원인]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg을(를) %s님이 냄비에 추가했습니다
노트]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s이(가) 지불함 |c00%s%sg
%에스]];
L.GDKP_AUCTION_DETAILS_WON_BY = "승리자";
L.GDKP_AUCTION_PAID_AMOUNT = "지불 금액 설정(왼쪽 읽기)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul은 거래된 금을 자동으로 추적합니다. 플레이어가 돈을 지불하는 한
그들이 구매한 제품에 대해서는 이 필드가 필요하지 않습니다.

'결제 금액'은 구매자가 이미 거래한 골드 금액을 의미합니다.
이는 품목의 실제 가격을 변경하지 않습니다!

경고: 플레이어가 지불하겠다고 약속한 경우에만 여기에 값을 설정하세요.
레이드 외에서나 알트/메일 등에서 골드를 거래할 수 있어요!


]];
L.GDKP_AWARD_DIALOG_LABEL = "GDKP 가격:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "%s에 대해 %s에게 %s을(를) 부여하시겠습니까?";
L.GDKP_BIDDER_AUTO_BID = "자동 입찰";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "최대 입찰가는 얼마입니까? (최소 %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "입찰이 거부되었습니다!";
L.GDKP_BIDDER_ITEM_PRICING = "최소 입찰가: %sg 증분: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(최대 %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "새로운 입찰";
L.GDKP_BIDDER_STOP_AUTO_BID = "자동 입찰 중지";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "최고 입찰가: %s by %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "최고 입찰가: 귀하가 %s";
L.GDKP_CREATE = "새 GDKP 세션 만들기";
L.GDKP_CREATE_MANAGEMENT_CUT = "관리 삭감 %";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut은 비어 있거나 0에서 99 사이여야 합니다(% 기호 없음!).";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "세션 유형을 선택하세요!";
L.GDKP_CREATE_SESSION_SWITCH = "이 세션으로 전환";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFF다중 경매를 사용하면 한 번에 여러 항목에 대한 입찰을 시작하여 작업 속도를 높일 수 있습니다!
시작하려면 이 세션을 만든 후 지침을 따르세요.

|c00A79EFFSSingle-Auction을 사용하면 대신 단일 품목을 경매하거나 대기열을 사용할 수 있습니다.

|c00A79EFF다중 경매를 선택하면 삭제된 항목이 대기열에 추가되지 않습니다.
|c00A79EFFMulti-Auction과 |c00A79EFFSSingle-Auction 및 대기열을 혼합할 수 있지만 사용하지 않는 것이 좋습니다.

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "경매 유형(자세한 내용은 |c00A79EFFi 참조)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "다중 경매";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "단일 경매";
L.GDKP_CREATE_SUCCESSFUL = "세션이 생성되었습니다. 게임이 충돌할 경우를 대비하여 올바르게 저장되도록 /reload를 권장합니다!";
L.GDKP_CUTS_ADD_RAIDER = "레이더 추가";
L.GDKP_CUTS_ADJUST_G = "조정 [g]";
L.GDKP_CUTS_ADJUST_P = "조정하다 [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "그룹채팅에서 베이스컷 알리기";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "모든 플레이어와 계산을 재설정하시겠습니까? 참고: 더 이상 공격대에 참여하지 않는 모든 플레이어는 목록에서 제거됩니다!";
L.GDKP_CUTS_DELETE_RAIDER = "레이더 삭제";
L.GDKP_CUTS_EDIT_RAIDER = "레이더 편집";
L.GDKP_CUTS_LOCK_TOOLTIP = "잠금 및 지불";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "금 거래 관리";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Mutator를 사용하면 플레이어에게 금을 더 많거나 적게 줄 수 있습니다.
예: 탱크에 2%의 추가 혜택을 주는 것은 돌연변이의 목적입니다!

참고: 여기서 mutator를 편집하거나 삭제하면 이 세션에서만 변경됩니다.

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "레이드에서는 안됨";
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
L.GDKP_CUTS_SUMMARY = "%s 레이더 | %s 컷 있음 | 총 지불금: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "가져올 항목이 없습니다. CSV를 다시 확인하세요.";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "플레이어 %s의 골드가 누락되었습니다.";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "헤더가 누락되었습니다. 참고: 대소문자를 구분합니다!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "플레이어 이름이 누락되었습니다.";
L.GDKP_DELETE_BID_INFO = "입찰을 삭제하세요. 경매를 먼저 중단해야 합니다!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "이 세션에 침입자를 추가하세요";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "사용자 정의(자신만의 형식 만들기)";
L.GDKP_EXPORT_AUCTIONS_JSON = "상세(JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "공유(다른 플레이어가 가져올 수 있음)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "사용자 정의 형식";
L.GDKP_EXPORT_CUSTOM_HEADER = "맞춤 헤더";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "사용자 정의(자신만의 형식 만들기)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@PLAYER,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "플레이어, 컷";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "세션이 잠긴 날짜/시간";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "플레이어에게 주어진 총 골드";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "플레이어에게 골드 우편 발송";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "플레이어로부터 받은 총 골드";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "첫 번째 항목이 수여된 날짜/시간";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "플레이어에게 금이 거래되었습니다.";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "아이템,플레이어,골드,와우헤드링크";
L.GDKP_EXPORT_FORMAT_START = "첫 번째 항목이 수여된 날짜/시간";
L.GDKP_EXPORT_FORMAT_TITLE = "GDKP 세션 제목";
L.GDKP_EXPORT_INCLUDE_DISENCHANTED = "마력 추출된 아이템 포함";
L.GDKP_EXPORT_POT_CHANGED = "냄비가 바뀌었다";
L.GDKP_GOLD_TRADES = "금 거래";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "확실합니까? 앞으로 나올 항목을 보거나 입찰할 수 없습니다!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! 경고 !!|r

연결된 영역에 있고 플레이어 이름을 가져오는 중입니다.
예를 들어 영역 접미사 '%s'입니다. 이로 인해 전송이 발생할 수 있습니다.
잘못된 플레이어에게 메일을 자르고 잘라냅니다.

연결된 영역에 있을 때는 항상 플레이어의 영역 이름을 포함하도록 노력하세요!

계속 가져오시겠습니까?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "이렇게 하면 잘라내기 창에 대한 모든 변경 사항이 무시됩니다. 계속하시겠습니까?";
L.GDKP_IMPORT_CUTS_INFO = [[
Google 시트처럼 자신의 계산에서 선수 컷을 가져올 수 있습니다. 소프트레스 GDKP 등

형식은 다음과 같습니다(|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333플레이어,골드|c00967FD2
플레이어1,4000
플레이어2,4125
플레이어3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
GDKP 최소 가격 및 증분을 가져옵니다.

형식은 다음과 같습니다. 항목 ID + 최소 또는 증분이 필요합니다. (|c00BE3333헤더가 필요합니다!!):

|c00BE3333항목ID,최소,증분|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "기존 가격 설정을 삭제하시겠습니까? 모든 가격 데이터를 삭제하려면 예를 클릭하고, 여기에 제공한 데이터로 기존 가격 데이터를 재정의하려면 아니요를 클릭하세요.";
L.GDKP_IMPORT_SESSION = "GDKP 세션 가져오기";
L.GDKP_IMPORT_SESSION_ABOUT = "여기에서 GDKP 세션을 가져오고 계속할 수 있습니다. 누군가로부터 GDKP 세션을 얻으려면 |c00FFF569/gdkp에서 '공유(다른 플레이어가 가져올 수 있음)' 형식을 선택하여 내보내야 합니다.";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "%s이(가) 생성한 GDKP 세션을 가져오려고 합니다. 계속하시겠습니까?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "%s이(가) 만든 GDKP 세션이 이미 존재하는 것 같습니다. 무시하시겠습니까?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "GDKP 확장에 잘못된 데이터가 제공되었습니다!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "GDKP 일정 변경에 잘못된 데이터가 제공되었습니다!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "GDKP 단축에 잘못된 데이터가 제공되었습니다!";
L.GDKP_INVALID_DATA_FOR_START = "GDKP 경매 시작에 잘못된 데이터가 제공되었습니다!";
L.GDKP_INVALID_PAID_AMOUNT = "'유료'에 잘못된 번호가 제공되었습니다.";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "경매에 잘못된 시간이 제공되었습니다:일정 변경";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP 데이터(%sx 판매됨)
마지막 판매 기간: %s
평균 가격: %s
최소 입찰가: %s
증분: %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "잔액: |c0092FF000 ? 당신은 정사각형입니다! | |c00BE333330 ? 당신은 %s 30g을 빚지고 있습니다 | |c00F7922E50 ? %s님이 당신에게 50g을 빚지고 있습니다";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "%s님이 금을 우편으로 보냈습니다.";
L.GDKP_LEDGER_LEGEND_PAID_TO = "%s에게 골드 지급";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "%s로부터 금을 받았습니다.";
L.GDKP_LEDGER_MUTATION = "골드 %s 님"; -- %s = removed or added
L.GDKP_LEDGER_POT = "총 팟: %sg | 관리 절단: %sg(%s%%) | 배포: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | 작성자: %s%s | |c00967FD2%s에서";
L.GDKP_LOCKED_SESSION = "GDKP 세션을 사용할 수 없거나 잠겨 있습니다.";
L.GDKP_MAIL_ALL = "모두 메일 보내기";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Legendary+ 항목에 대한 입찰이 감지되지 않았습니다. 수동으로 계속하세요!";
L.GDKP_MISSING_CONTENT_FOR_START = "경매에 콘텐츠가 없습니다:시작";
L.GDKP_MULTIAUCTION_ABOUT = [[

다중 경매(또는 일괄 경매)를 사용하면 원하는 만큼 많은 품목을 한 번에 경매할 수 있습니다!
이를 통해 습격의 밤 속도가 엄청나게 빨라지고 침입자에게 원활한 경험이 제공됩니다.

아직 인벤토리에 있는 모든 거래 가능한 아이템은 '인벤토리에서 채우기'를 통해 자동으로 경매될 수 있습니다.
한번 시도해 보세요!

|c00808080단 하나의 단점이 있습니다. 사람들이 일괄 경매에 참여하려면 침입자에게 Gargul이 필요하다는 것입니다!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "활성(잠금 해제된) GDKP 세션이 있어야 합니다!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "이 창이 열린 상태에서 %s개의 항목을 목록에 추가하거나 아래 '인벤토리에서 채우기'를 클릭하세요."; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "단 몇 초 만에 저격 방지";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "저격 방지 값은 0(비어 있음) 또는 >=5여야 합니다.";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "항목 선택기로 돌아가기";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "목록에서 모든 항목 제거";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "재고에서 채우기";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "인벤토리의 거래 가능 아이템을 목록에 추가하세요.";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
여기에서 다중 경매 세션에 포함할 품목을 결정합니다.

목록에 아직 거래할 수 있는 아이템을 추가하려면 아래의 |c00A79EFFF인벤토리 채우기 버튼을 사용하세요.
이 창을 지우고 다시 열 때마다 마지막 채우기 설정이 자동으로 항목을 추가하는 데 사용됩니다.

|c00A79EFF%s 항목을 목록에 수동으로 추가하려면
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "다음 단계: Raider의 추가 기능 버전의 호환성을 확인하세요.";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "모든 사람이 Gargul을 사용하고 있는 것은 아닙니다. 경매를 시작하시겠습니까?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "경매 항목을 하나 이상 선택하세요.";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Gargul이 오래되었습니다. 문제를 방지하려면 세션을 시작하기 전에 업데이트하는 것이 좋습니다!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "모든 사람이 최신 상태를 유지하는 것은 아닙니다. 문제가 발생하면 침입자에게 업데이트를 요청하세요!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "활성 다중 경매가 있습니다. 여기에 추가하는 항목은 기존 세션에 추가됩니다. 중복상품에 주의하세요!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "이름 또는 iLVL 검색";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "항목 이름과 iLVL을 지원합니다. '252', '<252' 등";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "활성 GDKP 세션: |c00967FD2%s | 작성자: %s%s | |c00967FD2%s에서";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "경매 시간(초)";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "초 단위의 경매 시간은 >= 10이어야 합니다.";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "GDKP 입찰 세션 중에 떠났습니다. 이를 재개하려면 판매되지 않은 항목에 대해 새로운 입찰 시간(초)을 제공해야 합니다.";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "이 창이 열려 있으면 %s개 항목을 목록에 추가할 수 있습니다.";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "경매를 관리하려면 톱니바퀴 아이콘을 클릭하세요.";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "귀하는 이미 %s의 최고 입찰자입니다.";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
입찰 |c00%s%sg
작성자: %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%s닫음
입찰 없음]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
최소: |c00%s%sg
증분: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "항목: %s - 총 판매 수: %sg - 내가 약속한 항목: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
입찰 항목: %s/%s
총 판매 수: %s
내가 구입함: %s
총 입찰가(판매된 금액은 포함되지 않음): %s
내가 입찰함(판매된 항목은 포함되지 않음): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%s판매됨
|c00%s%sg에 대한 %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
입찰 |c00%s%sg
작성자: c0092FF00YOU!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "%s에 대한 자동 입찰을 중지할 수 없습니다. 다시 시도하거나 /reload하세요!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "최대 %sg까지 자동 입찰";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "왼쪽에 입력한 입찰가까지 자동 입찰";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "자동 입찰 중지(%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "%s에 대한 입찰을 확인할 수 없습니다.";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "입찰가가 잘못되었거나 입찰가가 너무 낮습니다. 최소값은 %sg입니다.";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "동일한 항목에 대한 입찰 사이에 2초를 기다려야 합니다.";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "입찰가 지우기";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "경매에서 모든 입찰을 제거합니다.";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "모두 닫기";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "모든 경매를 종료하시겠습니까?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
모든 경매 종료

활성 입찰이 있는 경매는 판매되며 새 입찰을 받을 수 없습니다!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "경매 종료";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "경매를 종료합니다. 플레이어는 더 이상 입찰할 수 없지만 가장 높은 입찰은 계속 활성화됩니다.";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "입찰 세부정보를 포함하여 경매에서 항목을 제거합니다. 이 작업은 취소할 수 없습니다!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "완성되었으나 팔리지 않은 아이템을 모두 추출하시겠습니까?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
팔리지 않은 아이템을 추출하세요

이렇게 하면 판매되지 않은 모든 항목이 마법 해제된 것으로 표시되며 새로운 다중 경매 세션에 표시되지 않습니다.
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "이 항목을 즐겨찾기에 추가";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "최종 통화 타이머를 몇 초로 설정하시겠습니까?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "최소 시간(초)은 5입니다.";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "(보통 더 짧은) 입찰 타이머를 제공하여 이 경매에 대한 최종 호출을 시작합니다.";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "모든 경매를 종료하고 다중 경매 세션을 마무리하시겠습니까?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
다중 경매 세션 완료

그러면 모든 경매가 종료되고 채팅에 총 팟이 표시됩니다.
활성 입찰이 있는 경매는 판매되며 새 입찰을 받을 수 없습니다!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "비활성 숨기기";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "사용할 수 없는 숨기기";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "완료된 경매 표시/숨기기";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "경매 관리";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "최소 요구 금액으로 입찰하세요";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "입찰 창이 닫혔습니다. 다시 열려면 |c00A79EFF/gl 입찰을 사용하세요!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "채팅으로 판매 공지";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "입찰가 초과 시 소리 재생";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "더 많은 사운드 옵션...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "모두 보이기";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "즐겨찾기 표시";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "비활성 표시";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "사용할 수 없음 표시";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "이 품목은 판매되었습니다. 변경하려면 원장(|c00%s/gdkp)을 사용하세요!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "끝내다";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "모든 입찰가를 삭제하고 모든 경매를 종료하시겠습니까?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
다중 경매 세션 종료

아직 판매되지 않은 품목에 대한 모든 입찰이 삭제되고 모든 경매가 종료됩니다!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "자세한 내용을 보려면 아래 버튼 위로 마우스를 가져가세요.";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "사용할 수 없는 항목 표시/숨기기";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "GDKP 경매 시작에 잘못된 데이터가 제공되었습니다!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s는 %s을(를) %sg에 구입했습니다.";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "전리품 마스터(%s)가 오래되었습니다. 이로 인해 입찰이 실패할 수 있습니다!";
L.GDKP_MULTIAUCTION_OUTBID = "당신은 입찰가가 높았어요!";
L.GDKP_MUTATORS = "돌연변이";
L.GDKP_MUTATOR_ADD = "돌연변이 추가";
L.GDKP_MUTATOR_APPLY_LABEL = "자동 적용 대상";
L.GDKP_MUTATOR_CREATE_NEW = "새로운 GDKP 뮤테이터 생성";
L.GDKP_MUTATOR_DELETE_BYPASS = "삭제. 확인을 우회하려면 Shift를 누르세요.";
L.GDKP_MUTATOR_EDIT = "돌연변이 편집";
L.GDKP_MUTATOR_FLAT_LABEL = "균일 금율 [예: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "정액 요금은 숫자여야 합니다.";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
예:
|c00967FD2SELF,RL,힐러]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "키워드를 사용하여 이 돌연변이원을 침입자에게 자동으로 적용할 수 있습니다.";
L.GDKP_MUTATOR_NAME_LABEL = "이름 [예: 탱크]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Mutator 이름에는 점(.)이 포함될 수 없습니다.";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "백분율 [예: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "백분율은 숫자여야 합니다.";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "향후 세션을 위해 저장";
L.GDKP_MUTATOR_UNKNOWN = "알 수 없는 돌연변이자: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "사용자 '%s'은(는) 경매를 시작할 수 없습니다.";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "사용자 '%s'은(는) 경매를 중지할 수 없습니다.";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "사용자 '%s'은(는) 경매를 중지할 수 없습니다. 경매가 유효하지 않습니다.";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "분배할 골드가 충분하지 않습니다. 이상한 삭감 계산이 예상됩니다!";
L.GDKP_NO_BIDS = "입찰이 없습니다!";
L.GDKP_OUTBID = "당신은 입찰가가 높았어요!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(활동적인)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
골드를 조정하려면 리드 또는 마스터 전리품이 필요합니다.
잠긴/삭제된 세션에서는 골드를 조정할 수 없습니다.]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "금 추가/제거";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s 유급의 |c00%s%s ~을 위한
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333%s에 의해 삭제됨
원인]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(삭제됨)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
항목을 삭제하려면 리드 또는 마스터 전리품이 필요합니다.
잠긴/삭제된 세션에서는 항목을 삭제할 수 없습니다.]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "이 항목을 삭제하는 이유를 입력하세요.";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "삭제. Shift 키를 누르고 있으면 메모를 무시할 수 있습니다.";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "경매가 연결된 세션은 48시간 후에 삭제됩니다.";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
항목을 편집하려면 리드 또는 마스터 전리품이 필요합니다.
삭제된 항목이나 잠긴/삭제된 세션의 항목은 편집할 수 없습니다.]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "다른 사람들이 세션 세부 정보를 보거나 귀하를 전리품 마스터로 교체할 수 있도록 세션을 내보냅니다.";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "다른 플레이어나 계정에서 세션 가져오기";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
원장의 전체 개요를 표시합니다.
스크린샷 목적에 이상적입니다!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "세션을 잠그면 잠금을 해제할 때까지 항목을 경매하거나 다른 내용을 변경할 수 없습니다. 그렇죠?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "세션 잠금 또는 잠금 해제";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "지불을 위해 세션을 잠급니다.";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "다중 경매: 여러 항목을 한 번에 경매합니다!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "에 추가됨";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s 화분 by %s
노트]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "에서 제거됨";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
냄비: %s
관리 절단(%s%%): %sg
플레이어당 컷(1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
항목을 복원하려면 리드 또는 마스터 전리품이 필요합니다.
잠긴/삭제된 세션의 항목은 복원할 수 없습니다.]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "작성자: %s%s | |c00%s%s%s에"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "팟이나 컷을 잠금 해제하고 변경하는 것은 매우 지저분할 수 있습니다. 특히 이미 지불금을 지불한 경우에는 더욱 그렇습니다. 확실합니까?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "세션 잠금 해제";
L.GDKP_PAYOUT_INACTIVE = "활성 GDKP 세션이 감지되지 않거나 지급을 위해 세션이 잠겨 있지 않습니다!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "증분 또는 최소값은 .0001보다 낮을 수 없습니다!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "항목 ID '%s'에 잘못된 '증분'이 제공되었습니다.";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "항목 ID '%s'에 잘못된 '최소'가 제공되었습니다.";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "항목 ID: %s에는 최소값 또는 증분값이 필요합니다.";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "헤더가 누락되었습니다. 참고: 대소문자를 구분합니다!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "%s 항목에 대한 데이터를 성공적으로 가져왔습니다.";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "알 수 없는 항목 ID: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s 가방, 전리품 창 또는 채팅 링크에 있는 항목을 이 경매 대기열에 추가할 수 있습니다.
현재 경매가 완료되면 대기열에 있는 항목이 자동으로 경매에 부쳐집니다. 이를 방지하려면 '%s' 버튼을 클릭하세요.

Gargul이 자동으로 경매를 낙찰하거나 마력을 해제하도록 하시겠습니까? 왼쪽에 있는 설정 휠을 열어보세요!

|c00FFF569알고 계셨나요?
드래그 앤 드롭으로 항목을 이동할 수 있습니다.
|c00A79EFF/reload를 수행하더라도 항목은 기억됩니다.
대기 중인 항목은 Gargul을 보유한 침입자에게 자동으로 표시되므로 사전 입찰이 가능합니다.
Gargul은 자동 약탈도 처리할 수 있습니다. |c00A79EFF/gl pm으로 확인해 보세요.
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "사용할 수 없는 항목 숨기기";
L.GDKP_SESSION = "GDKP 세션";
L.GDKP_SESSION_EDIT_TITLE = "%s 편집 중";
L.GDKP_SHOW_UPCOMING = "예정된 항목 표시";
L.GDKP_STOP_AUCTION_FIRST = "먼저 경매를 중단하세요!";
L.GDKP_THEY_OWE = "%s이(가) 당신에게 빚을 졌습니다 %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP 세션
플레이어가 소비한 금액: %s
주어진: %s
받았다: %s
플레이어 컷: %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "GDKP에서 제외";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "거래된 금은 주고받는 금액에 추가되지 않습니다.";
L.GDKP_TRADE_GIVEN_TO_LABEL = "금 |c00967FD2%s에게 주어졌습니다.";
L.GDKP_TRADE_GOLD_ADD_FAILED = "거래 창에 %s을(를) 추가할 수 없습니다. 수동으로 추가해보세요!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "%s에 지불할 돈이 부족합니다.";
L.GDKP_TRADE_GOLD_TO_GIVE = "주실 분: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "수신 대상: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "금 |c00967FD2%s에게서 받았습니다.";
L.GDKP_TRY_MULTIAUCTION = "다중 경매를 확인해보세요!";
L.GDKP_TUTORIAL_INFO = "Gargul GDKP를 빠르게 시작하려면 아래 단계를 따르세요!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "아래 |c00FFF569활성화 버튼을 클릭하여 이 세션을 활성화하십시오!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s 단일 항목을 경매하거나 대기열에 추가할 항목"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
유용한 명령:
- |c00FFF569/gdkp 이 창을 엽니다.
- |c00FFF569/gl ma 다중 경매 창 열기
- |c00FFF569/gl au 단일 항목 경매인/대기열 열기
- |c00FFF569/gl pm 자동 약탈 설정

]];
L.GDKP_TUTORIAL_STEP_DONE = "모든 것이 순조롭게 진행되었다면 여기에서 새로 경매된 품목을 볼 수 있습니다!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "한 번에 여러 품목을 경매하고 싶으십니까? |c00FFF569/gl ma (또는 |c00FFF569/gl 다중 경매)를 실행하거나 이 창 오른쪽 상단에 있는 다중 경매 아이콘을 클릭하세요!";
L.GDKP_TUTORIAL_STEP_NEW = "첫 번째 GDKP 세션을 생성하려면 아래의 |c00FFF569New 버튼을 클릭하세요. 생성되면 왼쪽에 표시됩니다.";
L.GDKP_TUTORIAL_STEP_READY = "아이템을 판매할 준비가 되었습니다! |c00BE3333첫 번째 GDKP 레이드를 시작하기 전에 아래의 모든 단계를 주의 깊게 읽고 직접 테스트해 보세요(레이드에 참가할 필요 없음)!";
L.GDKP_TUTORIAL_STEP_SELL = "아무도 입찰하지 않고 품목을 판매하고 싶으십니까? |c00FFF569%s 항목에 대해 우승자를 선택하고 가격을 설정하세요!";
L.GDKP_TUTORIAL_TITLE = "시작하기";
L.GDKP_UNKNOWN_ITEM = "경매에서 알 수 없는 항목 ID:생성: %s";
L.GDKP_UNKNOWN_SESSION = "경매에서 알 수 없는 sessionIdentifier:create: %s";
L.GDKP_YOU_OWE = "%s %s 빚을 졌습니다.";
L.GIVEN = "주어진";
L.GOLD_INDICATOR = "g";
L.GROUP = "그룹";
L.GROUP_MANAGER = "그룹 관리자";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "CurseForge에서 다운로드";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "정지";
L.HEADER = "머리글";
L.HELLO = "|c00%sGargul v%s 작성자: Zhorax@Firemaw. 시작하려면 |c00%s/gl 또는 |c00%s/gargul을 입력하세요!";
L.HIDE = "숨다";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "Gargul GDKP 개인화에 대해 자세히 알아보려면 아래 URL을 방문하세요.";
L.IDENTITY_TOOLTIP = "여기에 로고가 있나요? 자세한 내용을 보려면 클릭하세요!";
L.IMPORT = "수입";
L.IMPORTED_AND_UPDATED_ON = "|c00A79EFF%s(c00A79EFF%s)에서 가져옴, |c00A79EFF%s(c00A79EFF%s)에서 업데이트됨";
L.IMPORT_EXPLANATION = "어떤 종류의 데이터를 가져오시겠습니까?";
L.IMPORT_SUCCESSFUL = "부스트 롤 데이터 가져오기 성공";
L.INC = "Inc.";
L.INCLUDE_AWARDED = "이전에 수여된 항목 포함";
L.INCLUDE_BOES = "BOE 포함";
L.INCLUDE_MATERIALS = "재료 포함(Abyss Crystals 등)";
L.INCREMENT = "증가";
L.INFO = "정보";
L.INVALID_DATA_WARNING = "잘못된 데이터가 제공되었습니다.";
L.ITEM = "안건";
L.JSON_DECODE_WARNING = "JSON 데이터를 디코딩할 수 없습니다. 추가 문자나 공백을 추가하지 않고 있는 그대로 복사하여 붙여넣으세요!";
L.KEYS_INFO = [[
가르굴 아이템 단축키

롤아웃: |c00A79EFF%s
수상 내역: |c00A79EFF%s
마력 추출: |c00A79EFF%s


-- 이 창을 비활성화하려면 마우스 오른쪽 버튼을 클릭하세요 --
]];
L.LEDGER = "원장";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "당신은 약탈의 달인이 되거나 보조/주도 역할을 맡아야 합니다!";
L.LOCALE_CHANGE_NOTE = "참고: 설정에서 또는 |c00%s/gl 로케일을 통해 언제든지 로케일을 변경할 수 있습니다.";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul은 채팅 메시지를 영어로 게시합니다(기본값)
아래 드롭다운에서 다른 언어를 선택할 수 있습니다.

현재 채팅 언어는 '%s'입니다. 다른 언어를 활성화하면 /reload가 발생합니다!
]];
L.LOCALE_NONE_TITLE = "Gargul의 채팅 언어를 선택하세요";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "루루"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Gargul이 오작동할 가능성이 있는 하나 이상의 애드온이 설치되어 있습니다: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "SoftRes 지우기";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "TMB 지우기";
L.LOOTMASTER_DEFAULT_NOTE = "MS의 경우 /roll, OS의 경우 /roll 99";
L.LOOTMASTER_IMPORT_SR_BUTTON = "SoftRes 가져오기";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "TMB 가져오기";
L.LOOTMASTER_NOTICE_LABEL = "당신은 Master Looter의 역할을 맡았습니다.";
L.LOOTMASTER_OPEN_LABEL = "자동으로 이 창 열기";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "전리품 우선순위가 성공적으로 지워졌습니다.";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "다음 형식(항목당 1줄)으로 prio CSV를 제공하세요: id or name > prio1,equalprio > prio2 > etc";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "전리품 우선순위를 성공적으로 가져왔습니다.";
L.LOOTPRIORITY_INVALID_DATA = "잘못된 데이터가 제공되었습니다.";
L.LOOTPRIORITY_INVALID_LINE = "다음 줄에 잘못된 데이터가 제공되었습니다: '%s': 항목 ID 또는 우선순위가 누락되었습니다.";
L.LOOTPRIORITY_PROCESS_INCOMING = "%s에서 들어오는 전리품 우선순위를 처리하려고 시도 중입니다.";
L.LOOTPRIORITY_TOOLTIP_HEADER = "전리품 프리오";
L.MAIL = "우편";
L.MAILED = "우편으로 발송됨";
L.MAIL_CUTS_EXPLANATION = "플레이어에게 보내는 메일";
L.MAINSPEC_ABBR = "MS";
L.MAXIMIZE = "최대화";
L.MIN = "최소";
L.MINIMAP_BUTTON_AWARDED = "전리품 획득 내역";
L.MINIMAP_BUTTON_CUTS = "GDKP 삭감";
L.MINIMAP_BUTTON_EXPORT = "데이터 내보내기";
L.MINIMAP_BUTTON_GARGUL = "오픈 가르굴";
L.MINIMAP_BUTTON_IMPORT = "데이터 가져오기";
L.MINIMAP_BUTTON_LEDGER = "GDKP 원장";
L.MINIMAP_BUTTON_MULTIAUCTION = "다중경매";
L.MINIMAP_BUTTON_SETTING_INFO = "/gl 미니맵에서 설정 변경";
L.MINIMIZE = "최소화";
L.MINIMIZE_ON_AWARD = "수상 시 최소화";
L.MINIMIZE_ON_START = "시작 시 최소화";
L.MINIMUM = "최저한의";
L.MINIMUM_ITEM_LEVEL = "최소 아이템 레벨";
L.MINIMUM_QUALITY = "최소 품질";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "이동하다";
L.MULTI_AUCTION = "다중 경매";
L.NAME = "이름";
L.NEW = "새로운";
L.NEXT = "다음";
L.NO = "아니요";
L.NONE = "없음";
L.NOTE = "메모";
L.NOTHING = "아무것도 아님";
L.NO_BIDS_ACTION = "아무도 입찰하지 않을 때:";
L.NO_OFFICER_PRIVILEGES = "당신은 장교 특권이 없습니다";
L.OFFSPEC_ABBR = "운영체제";
L.OK = "좋아요";
L.OPEN = "열려 있는";
L.OPEN_AUCTIONEER = "공개 경매";
L.OPEN_MULTI_AUCTION = "다중 경매 공개";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "%s을(를) 디스인챈트로 설정하시겠습니까?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "%s을(를) %s에게 보내시겠습니까? 이 마력 제거기를 제거하려면 /gl cd를 입력하세요!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "디스인챈터가 설정되지 않았습니다. 설정하려면 /gl sd [mydisenchanter]를 사용하세요.";
L.PACKMULE_WHO_IS_DISENCHANTER = "당신의 환각자는 누구입니까?";
L.PAID = "유급의";
L.PASS = "통과하다";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "플레이어";
L.PLAYER_ITEM_WON_COUNT = "%s님이 획득한 아이템:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "플러스원";
L.PLUSONES_AWARD_DIALOG_LABEL = "+1 추가";
L.PLUSONES_BROADCAST_CONFIRM = "당신의 플러스원 데이터를 파티/공격대원 모두에게 방송하시겠습니까?";
L.PLUSONES_BROADCAST_PROCESS_START = "%s에서 들어오는 PlusOnes 데이터를 처리하려고 시도하는 중입니다.";
L.PLUSONES_CLEAR_CONFIRM = "%s는 모든 PlusOne 데이터를 삭제하려고 합니다. 모든 데이터를 삭제하시겠습니까?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "기존 PlusOne 데이터를 지우고 %s에서 브로드캐스트하는 새 데이터를 가져오시겠습니까?";
L.PLUSONES_IMPORT_CONFIRM = "%s에서 브로드캐스트하는 새 데이터를 가져오시겠습니까?";
L.PLUSONES_IMPORT_ERROR = "잘못된 데이터가 제공되었습니다. 내용이 필수 형식을 따르고 헤더 행이 포함되어 있지 않은지 확인하세요.";
L.PLUSONES_IMPORT_INFO = [[
여기서는 CSV 또는 TSV 형식의 테이블에서 플러스원 데이터를 가져오거나 Google Docs 시트에서 붙여넣을 수 있습니다.

테이블에는 플레이어 이름과 포인트 금액이라는 두 개 이상의 열이 필요합니다. 추가 열은 무시됩니다.

다음은 예시 라인입니다:

푸바,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "%s에서 들어오는 브로드캐스트를 자동으로 수락합니다.";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "모든 수신 +1 공유 데이터 차단";
L.PLUSONES_UPDATE_CONFIRM = [[
기존 PlusOne 데이터를 %s의 데이터로 업데이트하시겠습니까?

귀하의 최신 업데이트는 |c00A79EFF%s에 있었고, 해당 업데이트는 |c00A79EFF%s에 있었습니다.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "냄비";
L.PRICE = "가격";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "흔한";
L.QUALITY_EPIC = "서사시";
L.QUALITY_HEIRLOOM = "법정 상속 동산";
L.QUALITY_LEGENDARY = "전설적인";
L.QUALITY_POOR = "가난한";
L.QUALITY_RARE = "희귀한";
L.QUALITY_UNCOMMON = "드문";
L.QUEUE = "대기줄";
L.RAIDERS = "레이더스";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "누가 실종됐나요?";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "누락된 플레이어 이름 표시";
L.RAIDGROUPS_DISBAND_BUTTON = "레이드 해산";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "공격대를 해체하세요";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s님이 명단에 두 번 등재되어 있습니다!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "|c00FFF569Raid-Helper 내보내기('세로로 정렬된 그룹' 변형 사용) 또는 |c00FFF569Gargul 그룹 구성 CSV:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
아래의 큰 편집 상자에서 명단을 제공하고 모든 사람을 초대하고 누락된 사람을 확인하고 그룹을 적용하고 탱크를 할당할 수 있습니다.

|c00FFF569와우헤드 공격대 구성 링크를 제공하실 수 있습니다:]];
L.RAIDGROUPS_GARGUL_BUTTON = "가르굴 그룹 위키";
L.RAIDGROUPS_GARGUL_INFO = "공격대 그룹 형식에 대한 자세한 내용은 Gargul 그룹 위키를 방문하세요.";
L.RAIDGROUPS_IMPOSTER_WARNING = "다음 플레이어는 명단에 포함되어 있지 않습니다: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "잘못된 그룹 데이터가 제공되었습니다. 형식을 확인하세요!";
L.RAIDGROUPS_INVITE_BUTTON = "초대하다";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "명단에 있는 플레이어에게 초대장 보내기";
L.RAIDGROUPS_IN_COMBAT_WARNING = "%s이(가) 전투 중인 동안에는 그룹을 정렬할 수 없습니다!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "습격을 당해야 해요!";
L.RAIDGROUPS_NO_TANKS_WARNING = "정의된 탱크가 없습니다.";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "%s님을 위한 장소를 찾을 수 없습니다. 1개 그룹에 5명 이상을 배치하려고 하시나요?";
L.RAIDGROUPS_PURGE_BUTTON = "원치 않는 플레이어를 추방하세요";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "명단에 없는 선수를 추방하세요.";
L.RAIDGROUPS_SORTING_ERROR = "%s을(를) 이동하는 동안 문제가 발생했습니다";
L.RAIDGROUPS_SORTING_FINISHED = "레이드 명단 적용 완료";
L.RAIDGROUPS_SORTING_GROUPS = "그룹 정렬";
L.RAIDGROUPS_SORT_BUTTON = "그룹 적용";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "명단을 기준으로 그룹 정렬";
L.RAIDGROUPS_SORT_IN_PROGRESS = "아직 정렬이 진행 중입니다. 조금만 기다려주세요!";
L.RAIDGROUPS_TANKS_ASSIGNED = "모든 탱크가 할당되었습니다.";
L.RAIDGROUPS_TANK_BUTTON = "탱크 배정";
L.RAIDGROUPS_WOWHEAD_BUTTON = "와우헤드 합성 도구";
L.RAIDGROUPS_WOWHEAD_INFO = "아래 URL을 통해 와우헤드 구성 도구를 방문하실 수 있습니다. 구성 요소를 만든 후 여기에 붙여넣거나 Gargul 그룹 창의 큰 편집 필드에 붙여넣을 수 있습니다.";
L.REMOVE_BID = "입찰 삭제";
L.RESET_SETTINGS = "재설정 설정";
L.RESET_SETTINGS_CONFIRMATION = "Gargul의 모든 설정을 재설정하시겠습니까? 이 작업은 취소할 수 없습니다!";
L.RESET_UI = "가르굴 UI 재설정";
L.RESET_UI_CONFIRMATION = "Gargul의 모든 창 크기, 위치 및 배율을 재설정하시겠습니까? 이 작업은 취소할 수 없습니다!";
L.RESTORE = "복원하다";
L.RESUME = "재개하다";
L.RIGHT_SYMBOL = ">";
L.ROLL = "롤";
L.ROLLING_AWARD_CONFIRM = "%s을(를) %s에게 수여하시겠습니까?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "수상 마감";
L.ROLLING_CLOSE_ON_START_LABEL = "시작 시 닫기";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "수상 확인을 우회하려면 교대근무를 보류하세요.";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "수상 확인을 표시하려면 교대 근무를 기다리세요.";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
경고: 동점을 나타낼 수 있는 또 다른 동일한 굴림이 발견되었습니다.

]];
L.ROLLING_INVALID_START_DATA_WARNING = "시작 롤에 잘못된 데이터가 제공되었습니다!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(주어진 아이템: 예)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(주어진 아이템 : 아니오)";
L.ROLLING_ITEM_WON_OS = "(OS)";
L.ROLLING_NOTE_LABEL = "메모";
L.ROLLING_NO_ROLLOFF_WARNING = "출시를 중지할 수 없으며 진행 중인 출시가 없습니다.";
L.ROLLING_PASS_BUTTON = "통과하다";
L.ROLLING_REOPEN_ROLL_COUNT = "롤: %s";
L.ROLLING_REOPEN_TOOLTIP = "마스터 루터 창 열기";
L.ROLLING_ROLL_ACCEPTED = "롤 승인됨!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "현재 롤이 진행 중입니다.";
L.ROLLING_ROLL_PRIOLIST = "우선 순위 [%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "[%s] 소원";
L.ROLLING_SELECT_PLAYER_WARNING = "먼저 플레이어를 선택해야 합니다.";
L.ROLLING_TIMER_LABEL = "타이머(초)";
L.ROLLING_UNUSABLE_ITEM = "이 아이템을 사용할 수 없습니다!";
L.ROLLING_WINNER_NOT_UNIQUE = "우승자의 이름이 고유하지 않습니다. %s 상을 주고 싶은 플레이어를 선택하세요.";
L.SECONDS_ABBR = "에스";
L.SELECT_ALL = "모두 선택 / 비활성화";
L.SESSION = "세션";
L.SETTINGS = "설정";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "들어오는 입찰 발표";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "아이템 수여 후 냄비 발표";
L.SETTINGS_ANNOUNCE_START = "경매 시작 알림";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "레이드 경고에서 카운트다운 알림";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "습격 경고를 통해 들어오는 입찰을 알립니다.";
L.SETTINGS_RESET_UI = "가르굴 UI 재설정";
L.SETTINGS_WHISPER_BID_TOO_LOW = "입찰가가 너무 낮으면 입찰자에게 귓속말을 보내세요.";
L.SILVER_INDICATOR = "s";
L.SKIP = "건너뛰다";
L.SOFTRES = "소프트 리저브";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "당신의 소프트레스 데이터를 파티/레이드의 모든 사람에게 방송하시겠습니까?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "%s에서 받은 SoftRes 데이터를 처리할 수 없습니다.";
L.SOFTRES_CLEAR_CONFIRM = "기존의 모든 소프트 예약 데이터를 지우시겠습니까?";
L.SOFTRES_EVERYONE_RESERVED = "모두가 소프트 리저브를 채웠습니다.";
L.SOFTRES_FEATURE_MISSING = [[
소프트 예약이 있기 때문에 하드 예약 정보를 사용할 수 없습니다.
제공된 항목은 Softres.it의 'Gargul 내보내기' 버튼을 사용하여 생성되지 않았습니다.]];
L.SOFTRES_IMPORT_DETAILS = "|c00A79EFF%s의 |c00A79EFF%s에서 가져옴";
L.SOFTRES_IMPORT_FIXED_NAME = "자동 이름 수정: '%s'의 SR이 이제 '%s'에 연결되었습니다.";
L.SOFTRES_IMPORT_INFO = "시작하려면 먼저 Softres.it에 대한 공격대를 만들어야 합니다. 그런 다음 '애드온 내보내기'를 클릭하고 'Gargul'을 선택한 후 데이터를 복사하여 아래 양식에 붙여넣습니다.";
L.SOFTRES_IMPORT_INVALID = "잘못된 소프트 예약 데이터가 제공되었습니다.";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "잘못된 데이터가 제공되었습니다. Softres.it에서 'Gargul 내보내기' 버튼을 클릭하고 여기에 전체 내용을 붙여넣으세요.";
L.SOFTRES_IMPORT_NEW_PLUSONES = "제공된 PlusOne 값이 이미 존재하는 값과 충돌합니다. 이전 PlusOne 값을 교체하시겠습니까?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "다음 플레이어는 아무것도 예약하지 않았습니다.";
L.SOFTRES_IMPORT_SUCCESSFUL = "소프트 예약을 성공적으로 가져왔습니다.";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "가져오기 성공!";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura 및 CSV 데이터는 더 이상 사용되지 않습니다. 대신 Gargul 내보내기를 사용하세요!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "LootReserve에 연결하지 못했습니다. 지원팀에 문의하세요(아래 메시지 포함).";
L.SOFTRES_MULTIPLE_RESERVES = "%s(%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "사용할 수 있는 Softres.it URL이 없습니다. Softres.it의 'Gargul 내보내기' 버튼을 사용하여 내보냈는지 확인하세요!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "하드 예약 정보를 보려면 여기를 클릭하세요.";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "하드 예약된 항목이 없습니다.";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "사용 가능한 하드 예약 정보가 없습니다.";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "누락된 SR 게시";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "SR 게시 URL";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "이 플레이어는 아무것도 예약하지 않았습니다!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s(%sx)";
L.SOFTRES_PROCESS_INCOMING = "%s에서 들어오는 SoftRes 데이터를 처리하려고 시도하는 중입니다.";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "이 항목은 예약되어 있습니다.";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "대상: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 참고: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "예약자";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "문제가 발생했습니다.";
L.START = "시작";
L.STOP = "멈추다";
L.TAB_REPLACES_T = "\\t is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "시간";
L.TITLE = "제목";
L.TMBETC = "TMB, DFT 또는 PRIO3";
L.TMB_BROADCAST_CONFIRM = "TMB 데이터를 파티/공격대원 모두에게 방송하시겠습니까? 주의: TMB 웹사이트의 권한에 관계없이 모든 사람이 귀하의 TMB 데이터를 볼 수 있습니다!";
L.TMB_BROADCAST_PROCESS_START = "%s에서 들어오는 TMB 데이터를 처리하려고 시도하는 중입니다.";
L.TMB_CLEAR_CONFIRM = "플러스원 데이터를 모두 삭제하시겠습니까?";
L.TMB_CLEAR_RAIDER_DATA = "레이더 데이터 지우기";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "모든 침입자의 TMB 데이터를 삭제하시겠습니까?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "자동 공유 활성화됨: %s";
L.TMB_IMPORT_CPO_INFO = "classicpr.io 실행에서 'Gargul 내보내기' 버튼을 클릭하고 내용을 복사하세요. 이후 아래 박스에 내용을 그대로 붙여넣고 '가져오기'를 클릭하세요. 그게 다야!";
L.TMB_IMPORT_DETAILS = "${date} ${time}에 가져옴";
L.TMB_IMPORT_DFT_INFO = "시트의 지침에 따라 DFT 데이터를 내보냅니다. 이후 아래 박스에 내용을 그대로 붙여넣고 '가져오기'를 클릭하세요. 그게 다야!";
L.TMB_IMPORT_INVALID_CSV = "제공된 CSV가 잘못되었습니다. 형식은 6948,player1,player2입니다.";
L.TMB_IMPORT_INVALID_DFT = "잘못된 DFT 데이터가 제공되었습니다. 시트의 지침에 따라 DFT 데이터를 내보내고 여기에 내용을 그대로 붙여넣으세요.";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "잘못된 TMB 데이터가 제공되었습니다. Gargul 섹션에서 '다운로드' 버튼을 클릭하고 내용을 그대로 여기에 붙여넣으세요!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "잘못된 TMB 또는 DFT 데이터가 제공되었습니다. 내보내기 내용을 그대로 여기에 붙여넣으세요!";
L.TMB_IMPORT_NOTES_AVAILABLE = "사용 가능한 우선순위 메모: %s";
L.TMB_IMPORT_NUMBER = "가져온 항목 수: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "다음 플레이어에게는 %s 항목이 없습니다:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "${source}와 함께 Gargul을 사용하는 방법";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "TMB 내보내기 내용을 그대로 아래 상자에 붙여넣고 '가져오기'를 클릭하세요.";
L.TMB_NO_BROADCAST_TARGETS = "그룹에 방송할 사람이 없습니다.";
L.TMB_SYNCED = "TMB 데이터 동기화됨";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF 참고: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(OS)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s 우선 순위 목록"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF 계층: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB 위시리스트";
L.TOGGLE_DATES = "날짜 표시/숨기기";
L.TOGGLE_QUEUE = "대기열 표시/숨기기";
L.TRADETIME_AWARD_HOWTO = "%s님이 전리품을 드립니다!";
L.TRADETIME_ROLL_HOWTO = "%s 전리품을 출시하세요!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "수여된 모든 항목 숨기기";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "마력이 추출된 아이템 숨기기";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "자신에게 수여된 아이템 숨기기";
L.TRADE_ANNOUNCE = "거래 발표";
L.TRADE_ANNOUNCE_INFO = "거래 내역을 그룹에 알리거나 그룹에 속하지 않을 때 /say에 알리세요.";
L.TUTORIAL = "지도 시간";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s 가방, 전리품 창 또는 채팅 링크에 있는 항목을 경매 대기열에 추가할 수 있습니다.
입찰 없이 상품을 직접 판매하고 싶으신가요? |c00A79EFF%s 사용

|c00A79EFF/gl 경매를 입력하여 %s 창을 직접 열 수 있습니다.

Gargul은 |c00FF0000ALL 금 거래를 추적합니다. 이번 GDKP 세션에 거래가 포함되는 것을 원하지 않으시나요? 거래 시 'GDKP에서 제외' 확인란을 선택하세요!

|c00FFF569알고 계셨나요?
획득한 아이템은 자동으로 거래창에 추가됩니다.
Gargul은 자동 약탈도 처리할 수 있습니다. |c00A79EFF/gl pm으로 확인해 보세요.
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
이 창에는 특정 날짜에 수여된 모든 항목이 표시됩니다(왼쪽에서 하나 이상의 날짜 선택).

항목에는 다음 태그가 포함될 수 있습니다.

|c00A79EFFOS: 오프스펙으로 수여됨
|c00A79EFFSR: 이 항목은 소프트 예약되었습니다.
|c00A79EFFWL: 이 항목은 위시리스트에 추가되었습니다(Thatsmybis)
|c00A79EFFPL: 이 항목은 우선적으로 등록되었습니다(Thatsmybis, DFT, prio3).
]];
L.TUTORIAL_BIDDER_QUEUE = [[
여기에 표시되는 항목은 마스터 루터의 GDKP 대기열에 있습니다.
해당 항목을 제거하고 입찰하고 사용할 수 없는 항목을 숨길 수 있습니다(왼쪽 상단 설정에서 '사용할 수 없는 항목 숨기기' 활성화).

창 크기를 조정하거나, 이동하거나, 최소화할 수 있습니다. 사용해 보세요!

전리품 마스터의 경우: 여기서 항목을 제거하면 실제 GDKP 대기열이 아닌 개인 대기열에서만 제거됩니다!
]];
L.TUTORIAL_MORE_HELP = "도움이 더 필요하신가요?";
L.TYPE = "유형"; -- As in type of roll or type of item
L.UNKNOWN = "알려지지 않은";
L.UNKNOWN_COMM_ACTION = "알 수 없는 통신 작업 '%s', Gargul을 업데이트하세요!";
L.UNLOCK = "터놓다";
L.UPDATE_GARGUL = "가르굴을 업데이트하세요!";
L.VERSION_ABBR = "V";
L.VERSION_CHECK_BUTTON_REPORT = "보고서";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "그룹 채팅에서 오래된 결과 신고";
L.VERSION_CHECK_COLUMN_STATUS = "가르굴 상태";
L.VERSION_CHECK_STATUS_CHECKING = "버전 확인 중...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: 플레이어가 최신 상태입니다.
|c00F7922Ev%s: 플레이어는 자신의 추가 기능을 업데이트해야 합니다.
|c00BE3333%s: 플레이어에 Gargul이 없거나 지원되지 않는 버전을 사용하고 있습니다.
|c00808080%s: 플레이어가 오프라인이거나 우리를 무시하고 있습니다!
|c0000FFFF%s: 해당 플레이어가 무시 목록에 있습니다!

]];
L.VERSION_CHECK_STATUS_IGNORED = "플레이어가 무시되었습니다!";
L.VERSION_CHECK_STATUS_OFFLINE = "오프라인";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "응답 없음";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "응답 없음:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "오프라인:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "시대에 뒤쳐진:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "최신 정보:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul은 최신 버전이 아니며 업데이트할 때까지 작동하지 않습니다!";
L.VERSION_INVALID_WARNING = "버전:addRelease에 잘못된 버전 문자열이 제공되었습니다.";
L.VERSION_UPDATE = "가르굴을 업데이트하세요!";
L.VERSION_UPDATED = "|c00%sGargul은 이제 |c00%sv%s로 업데이트되었습니다.";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s는 CurseForge/Wago에서 사용할 수 있습니다. 게임을 닫지 않고도 업데이트할 수 있습니다. /reload를 꼭 해주세요!";
L.WAIT_SECONDS_BEFORE_RETRY = "다시 시도하기 전에 %s초 더 기다리십시오.";
L.WINDOW = "창문";
L.WINDOW_HEADER = "가르굴 v%s";
L.WINDOW_SCALE = "창 규모";
L.WISHLIST_ABBR = "WL";
L.YES = "예";
L.YOU_DISABLED_GDKP_QUEUES = "GDKP 대기열을 비활성화했습니다.";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "zlib로 데이터를 압축할 수 없습니다. https://discord.gg/D3mDhYPVzf를 통해 지원팀에 문의하세요.";
L.ZLIB_DECOMPRESS_WARNING = "zlib로 데이터 압축을 풀 수 없습니다. 추가 문자나 공백을 추가하지 않고 있는 그대로 복사하여 붙여넣으세요!";
