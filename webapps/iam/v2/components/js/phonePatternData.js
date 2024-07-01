// $Id: $

/////////////////////JQuery not needed for this file////////////////

/////////////////////to initialize placeholder for country phone numbers use phonePattern.initialize(selectTag,phoneNo)/////////////////
	var phoneData = {"AC":{"pattern":"(\\d{5})","space":"$1","example":"12345","code":"+247"},"AD":{"pattern":"(\\d{3})(\\d{6})","space":"$1 $2","example":"123451234","code":"+376"},"AE":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+971"},"AF":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+93"},"AG":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"AI":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"AL":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+355"},"AN":{"pattern":"(\\d{8})","space":"$1","example":"12345123","code":"+599"},"AM":{"pattern":"(\\d{2})(\\d{6})","space":"$1 $2","example":"12345123","code":"+374"},"AO":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+244"},"AR":{"pattern":"(\\d)(\\d{2})(\\d{4})(\\d{4})","space":"$1 $2 $3-$4","example":"12345123451","code":"+54"},"AS":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"AT":{"pattern":"(\\d{3})(\\d{3,10})","space":"$1 $2","example":"1234512345123","code":"+43"},"AU":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+61"},"AW":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+297"},"AX":{"pattern":"(\\d{2})(\\d{4,8})","space":"$1 $2","example":"1234512345","code":"+672"},"AZ":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+994"},"BA":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+387"},"BB":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"BD":{"pattern":"(\\d{4})(\\d{3,6})","space":"$1-$2","example":"1234512345","code":"+880"},"BE":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+32"},"BF":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+226"},"BG":{"pattern":"(\\d{2})(\\d{3})(\\d{3,5})","space":"$1 $2 $3","example":"1234512345","code":"+359"},"BH":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+973"},"BI":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+257"},"BJ":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+229"},"BL":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+590"},"BM":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"BN":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+673"},"BO":{"pattern":"(\\d{8})","space":"$1","example":"12345123","code":"+591"},"BQ":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+599"},"BR":{"pattern":"(\\d{2})(\\d{5})(\\d{4})","space":"$1 $2-$3","example":"12345123451","code":"+55"},"BS":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"BT":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+975"},"BW":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+267"},"BY":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2-$3-$4","example":"123451234","code":"+375"},"BZ":{"pattern":"(\\d{3})(\\d{4})","space":"$1-$2","example":"1234512","code":"+501"},"CA":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"CC":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+61"},"CD":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+243"},"CF":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+236"},"CG":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+242"},"CH":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{5})","space":"$1 $2 $3 $4","example":"123451234512","code":"+41"},"CI":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4 $5","example":"1234512345","code":"+225"},"CK":{"pattern":"(\\d{2})(\\d{3})","space":"$1 $2","example":"12345","code":"+682"},"CL":{"pattern":"(\\d)(\\d{4})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+56"},"CM":{"pattern":"(\\d)(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4 $5","example":"123451234","code":"+237"},"CN":{"pattern":"(\\d{3})(\\d{4})(\\d{4})","space":"$1 $2 $3","example":"12345123451","code":"+86"},"CO":{"pattern":"(\\d{3})(\\d{7})","space":"$1 $2","example":"1234512345","code":"+57"},"CR":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+506"},"CU":{"pattern":"(\\d)(\\d{9})","space":"$1 $2","example":"1234512345","code":"+53"},"CV":{"pattern":"(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2 $3","example":"1234512","code":"+238"},"CW":{"pattern":"(\\d)(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"12345123","code":"+599"},"CX":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+61"},"CY":{"pattern":"(\\d{2})(\\d{6})","space":"$1 $2","example":"12345123","code":"+357"},"CZ":{"pattern":"(\\d{3})(\\d{3})(\\d{6})","space":"$1 $2 $3","example":"123451234512","code":"+420"},"DE":{"pattern":"(\\d{4})(\\d{11})","space":"$1 $2","example":"123451234512345","code":"+49"},"DG":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+246"},"DJ":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+253"},"DK":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+45"},"DM":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"DO":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"DZ":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+213"},"EC":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+593"},"EE":{"pattern":"(\\d{4})(\\d{3,4})","space":"$1 $2","example":"12345123","code":"+372"},"EG":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234512345","code":"+20"},"EH":{"pattern":"(\\d{3})(\\d{6})","space":"$1-$2","example":"123451234","code":"+212"},"ER":{"pattern":"(\\d)(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"1234512","code":"+291"},"ES":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+34"},"ET":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+251"},"FI":{"pattern":"(\\d{2})(\\d{4,8})","space":"$1 $2","example":"1234512345","code":"+358"},"FJ":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+679"},"FK":{"pattern":"(\\d{5})","space":"$1","example":"12345","code":"+500"},"FM":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+691"},"FO":{"pattern":"(\\d{6})","space":"$1","example":"123451","code":"+298"},"FR":{"pattern":"(\\d)(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4 $5","example":"123451234","code":"+33"},"GA":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+241"},"GB":{"pattern":"(\\d{4})(\\d{6})","space":"$1 $2","example":"1234512345","code":"+44"},"GD":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"GE":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+995"},"GF":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+594"},"GG":{"pattern":"(\\d{4})(\\d{6})","space":"$1 $2","example":"1234512345","code":"+44"},"GH":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+233"},"GI":{"pattern":"(\\d{8})","space":"$1","example":"12345123","code":"+350"},"GL":{"pattern":"(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3","example":"123451","code":"+299"},"GM":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+220"},"GN":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+224"},"GP":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+590"},"GQ":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+240"},"GR":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234512345","code":"+30"},"GT":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+502"},"GU":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"GW":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+245"},"GY":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+592"},"HK":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+852"},"HN":{"pattern":"(\\d{4})(\\d{4})","space":"$1-$2","example":"12345123","code":"+504"},"HR":{"pattern":"(\\d{2})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"123451234","code":"+385"},"HT":{"pattern":"(\\d{2})(\\d{2})(\\d{4})","space":"$1 $2 $3","example":"12345123","code":"+509"},"HU":{"pattern":"(\\d{2})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"123451234","code":"+36"},"ID":{"pattern":"(\\d{4})(\\d{4})(\\d{4})","space":"$1-$2-$3","example":"123451234512","code":"+62"},"IE":{"pattern":"(\\d{2})(\\d{3})(\\d{5})","space":"$1 $2 $3","example":"1234512345","code":"+353"},"IL":{"pattern":"(\\d{2})(\\d{3})(\\d{7})","space":"$1-$2-$3","example":"123451234512","code":"+972"},"IM":{"pattern":"(\\d{4})(\\d{6})","space":"$1 $2","example":"1234512345","code":"+44"},"IN":{"pattern":"(\\d{5})(\\d{5})","space":"$1 $2","example":"1234512345","code":"+91"},"IO":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+246"},"IQ":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234512345","code":"+964"},"IR":{"pattern":"(\\d{3})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"1234512345","code":"+98"},"IS":{"pattern":"(\\d{3})(\\d{6})","space":"$1 $2","example":"123451234","code":"+354"},"IT":{"pattern":"(\\d{3})(\\d{3})(\\d{3,6})","space":"$1 $2 $3","example":"123451234512","code":"+39"},"JE":{"pattern":"(\\d{4})(\\d{6})","space":"$1 $2","example":"1234512345","code":"+44"},"JM":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"JO":{"pattern":"(\\d)(\\d{4})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+962"},"JP":{"pattern":"(\\d{2})(\\d{4})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+81"},"KE":{"pattern":"(\\d{3})(\\d{6})","space":"$1 $2","example":"123451234","code":"+254"},"KG":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+996"},"KH":{"pattern":"(\\d{2})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"123451234","code":"+855"},"KI":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+686"},"KM":{"pattern":"(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2 $3","example":"1234512","code":"+269"},"KN":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"KP":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234512345","code":"+850"},"KR":{"pattern":"(\\d{2})(\\d{3,4})(\\d{5})","space":"$1-$2-$3","example":"12345123451","code":"+82"},"KW":{"pattern":"(\\d{3})(\\d{5})","space":"$1 $2","example":"12345123","code":"+965"},"KY":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"KZ":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234512345","code":"+7"},"LA":{"pattern":"(\\d{2})(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3 $4","example":"1234512345","code":"+856"},"LB":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+961"},"LC":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"LI":{"pattern":"(\\d{3})(\\d{2})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+423"},"LK":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+94"},"LR":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+231"},"LS":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+266"},"LT":{"pattern":"(\\d{3})(\\d{5})","space":"$1 $2","example":"12345123","code":"+370"},"LU":{"pattern":"(\\d{3})(\\d{3})(\\d{5})","space":"$1 $2 $3","example":"12345123451","code":"+352"},"LV":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+371"},"LY":{"pattern":"(\\d{2})(\\d{8})","space":"$1-$2","example":"1234512345","code":"+218"},"MA":{"pattern":"(\\d{3})(\\d{6})","space":"$1-$2","example":"123451234","code":"+212"},"MC":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{3})","space":"$1 $2 $3 $4","example":"123451234","code":"+377"},"MD":{"pattern":"(\\d{3})(\\d{2})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+373"},"ME":{"pattern":"(\\d{2})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"123451234","code":"+382"},"MF":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+590"},"MG":{"pattern":"(\\d{2})(\\d{2})(\\d{3})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+261"},"MH":{"pattern":"(\\d{3})(\\d{4})","space":"$1-$2","example":"1234512","code":"+692"},"MK":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+389"},"ML":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+223"},"MM":{"pattern":"(\\d)(\\d{3})(\\d{6})","space":"$1 $2 $3","example":"1234512345","code":"+95"},"MN":{"pattern":"(\\d{4})(\\d{6})","space":"$1 $2","example":"1234512345","code":"+976"},"MO":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+853"},"MP":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"MQ":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+596"},"MR":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+222"},"MS":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"MT":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+356"},"MU":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+230"},"MV":{"pattern":"(\\d{3})(\\d{4})","space":"$1-$2","example":"1234512","code":"+960"},"MW":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+265"},"MX":{"pattern":"(\\d{3})(\\d{3})(\\d{5})","space":"$1 $2 $3","example":"12345123451","code":"+52"},"MY":{"pattern":"(\\d{2})(\\d{3})(\\d{5})","space":"$1-$2 $3","example":"1234512345","code":"+60"},"MZ":{"pattern":"(\\d{2})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"123451234","code":"+258"},"NA":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+264"},"NC":{"pattern":"(\\d{2})(\\d{2})(\\d{2})","space":"$1.$2.$3","example":"123451","code":"+687"},"NE":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+227"},"NF":{"pattern":"(\\d)(\\d{5})","space":"$1 $2","example":"123451","code":"+672"},"NG":{"pattern":"(\\d{3})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"1234512345","code":"+234"},"NI":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+505"},"NL":{"pattern":"(\\d)(\\d{10})","space":"$1 $2","example":"12345123451","code":"+31"},"NO":{"pattern":"(\\d{3})(\\d{2})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+47"},"NP":{"pattern":"(\\d{3})(\\d{7})","space":"$1-$2","example":"1234512345","code":"+977"},"NR":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+674"},"NU":{"pattern":"(\\d{7})","space":"$1","example":"1234567","code":"+683"},"NZ":{"pattern":"(\\d{2})(\\d{3})(\\d{3,5})","space":"$1 $2 $3","example":"1234512345","code":"+64"},"OM":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+968"},"PA":{"pattern":"(\\d{4})(\\d{4})","space":"$1-$2","example":"12345123","code":"+507"},"PE":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+51"},"PF":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+689"},"PG":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+675"},"PH":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234512345","code":"+63"},"PK":{"pattern":"(\\d{3})(\\d{7})","space":"$1 $2","example":"1234512345","code":"+92"},"PL":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+48"},"PM":{"pattern":"(\\d{2})(\\d{2})(\\d{5})","space":"$1 $2 $3","example":"123451234","code":"+508"},"PR":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"PS":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+970"},"PT":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+351"},"PW":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+680"},"PY":{"pattern":"(\\d{3})(\\d{6})","space":"$1 $2","example":"123451234","code":"+595"},"QA":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+974"},"RE":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+262"},"RO":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+40"},"RS":{"pattern":"(\\d{2})(\\d{5,10})","space":"$1 $2","example":"123451234512","code":"+381"},"RU":{"pattern":"(\\d{3})(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2-$3-$4","example":"1234512345","code":"+7"},"RW":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+250"},"SA":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+966"},"SB":{"pattern":"(\\d{2})(\\d{5})","space":"$1 $2","example":"1234512","code":"+677"},"SC":{"pattern":"(\\d)(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"1234512","code":"+248"},"SD":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+249"},"SE":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{5})","space":"$1 $2 $3 $4","example":"123451234","code":"+46"},"SG":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+65"},"SH":{"pattern":"(\\d{5})","space":"$1","example":"12345","code":"+290"},"SI":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+386"},"SJ":{"pattern":"(\\d{3})(\\d{2})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+47"},"SK":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+421"},"SL":{"pattern":"(\\d{2})(\\d{6})","space":"$1 $2","example":"12345123","code":"+232"},"SM":{"pattern":"(\\d{4})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"1234512345","code":"+378"},"SN":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+221"},"SO":{"pattern":"(\\d{2})(\\d{7})","space":"$1 $2","example":"123451234","code":"+252"},"SR":{"pattern":"(\\d{3})(\\d{4})","space":"$1-$2","example":"1234512","code":"+597"},"SS":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+211"},"ST":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+239"},"SV":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+503"},"SX":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+721"},"SY":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+963"},"SZ":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+268"},"TC":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"TD":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+235"},"TG":{"pattern":"(\\d{2})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"12345123","code":"+228"},"TH":{"pattern":"(\\d{2})(\\d{3})(\\d{3,4})","space":"$1 $2 $3","example":"123451234","code":"+66"},"TJ":{"pattern":"(\\d{3})(\\d{2})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+992"},"TK":{"pattern":"(\\d{7})","space":"$1","example":"1234567","code":"+690"},"TL":{"pattern":"(\\d{4})(\\d{4})","space":"$1 $2","example":"12345123","code":"+670"},"TM":{"pattern":"(\\d{2})(\\d{6})","space":"$1 $2","example":"12345123","code":"+993"},"TN":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+216"},"TO":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+676"},"TR":{"pattern":"(\\d{3})(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"1234512345","code":"+90"},"TT":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"TV":{"pattern":"(\\d{2})(\\d{5})","space":"$1 $2","example":"1234567","code":"+688"},"TW":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+886"},"TZ":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+255"},"UA":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+380"},"UG":{"pattern":"(\\d{3})(\\d{6})","space":"$1 $2","example":"123451234","code":"+256"},"US":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"UY":{"pattern":"(\\d{2})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"12345123","code":"+598"},"UZ":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+998"},"VA":{"pattern":"(\\d{3})(\\d{3})(\\d{3,6})","space":"$1 $2 $3","example":"123451234512","code":"+379"},"VC":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"VE":{"pattern":"(\\d{3})(\\d{7})","space":"$1-$2","example":"1234512345","code":"+58"},"VG":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"VI":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1-$2-$3","example":"1234512345","code":"+1"},"VN":{"pattern":"(\\d{2})(\\d{3})(\\d{2})(\\d{3})","space":"$1 $2 $3 $4","example":"1234512345","code":"+84"},"VU":{"pattern":"(\\d{3})(\\d{4})","space":"$1 $2","example":"1234512","code":"+678"},"WF":{"pattern":"(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3","example":"123451","code":"+681"},"WS":{"pattern":"(\\d{2})(\\d{8})","space":"$1 $2","example":"1234512345","code":"+685"},"XK":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+383"},"YE":{"pattern":"(\\d{3})(\\d{3})(\\d{3})","space":"$1 $2 $3","example":"123451234","code":"+967"},"YT":{"pattern":"(\\d{3})(\\d{2})(\\d{2})(\\d{2})","space":"$1 $2 $3 $4","example":"123451234","code":"+262"},"ZA":{"pattern":"(\\d{2})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"123451234","code":"+27"},"ZM":{"pattern":"(\\d{2})(\\d{7})","space":"$1 $2","example":"123451234","code":"+260"},"ZW":{"pattern":"(\\d{2})(\\d{3})(\\d{5})","space":"$1 $2 $3","example":"1234512345","code":"+263"},"AQ":{"pattern":"(\\d{2})(\\d{4})","space":"$1 $2","example":"123456","code":"+672"},"HM":{"pattern":"(\\d{11})","space":"$1","example":"12345678901","code":"+672"},"BV":{"pattern":"(\\d{11})","space":"$1","example":"12345678901","code":"+47"},"TF":{"pattern":"(\\d{5})(\\d{5})","space":"$1 $2","example":"1234567890","code":"+262"},"PN":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234567890","code":"+64"},"GS":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234567890","code":"+500"},"UM":{"pattern":"(\\d{3})(\\d{3})(\\d{4})","space":"$1 $2 $3","example":"1234567890","code":"+1"}};//no i18n
	var phonePatternClosure = function(){
	if(newPhoneData){
		newPhoneData = JSON.parse(newPhoneData);
		for(var cnt in newPhoneData){phoneData[cnt] = newPhoneData[cnt]}
	}
	return function(){
		var obj = {};
		obj.mobileNumber = undefined;
		obj.tempMobile = undefined;
		obj.setDataforCountry = function(country,val){
			return phoneData[country] = val;
		};
		obj.getPhonePattern = function(country){
			return phoneData[country].pattern;
		};
		obj.getPhoneSpace = function(country){
			return phoneData[country].space;
		}
		obj.getPhoneExample = function(country){
			return phoneData[country].example;
		}
		obj.getCountryObj = function(country){
			return phoneData[country];
		}
		obj.setMobileNumPlaceholder =  function(selectEle,mobileNo,selectEvent){
			var mobInput = obj.findSiblingWithInputTypeTel(selectEle);
		    if(showMobileNoPlaceholder){
				mobInput.parentNode.replaceChild(mobInput.cloneNode(true),mobInput);
				mobInput = obj.findSiblingWithInputTypeTel(selectEle);
				var selected_cc = selectEle.selectedOptions[0].id;
				if(selectEvent){
					selectEle.addEventListener('change', function(e){
				    	selected_cc = selectEle.selectedOptions[0].id;
						if(typeof obj.tempMobile != "undefined" && obj.tempMobile != undefined){
							// users input value to be display when they change country and works only showmobileplaceholder is true
							obj.mobileNumber = obj.tempMobile.replace(/[^\d\+]/g,"");
				            mobInput.value = obj.setSeperatedNumber(phoneData[selected_cc],obj.mobileNumber);
						}
				    	mobInput.placeholder =phoneData[selected_cc].example.replace(new RegExp(phoneData[selected_cc].pattern),phoneData[selected_cc].space);
				    	mobInput.maxLength = mobInput.placeholder.length;  	
				    });
				}else{
					selectEle.onchange = function(e){
						selected_cc = selectEle.selectedOptions[0].id;
						if(typeof obj.tempMobile != "undefined" && obj.tempMobile != undefined){
							// users input value to be display when they change country and works only showmobileplaceholder is true
							obj.mobileNumber = obj.tempMobile.replace(/[^\d\+]/g,"");
				            mobInput.value = obj.setSeperatedNumber(phoneData[selected_cc],obj.mobileNumber);
						}
				    	mobInput.placeholder =phoneData[selected_cc].example.replace(new RegExp(phoneData[selected_cc].pattern),phoneData[selected_cc].space);
				    	mobInput.maxLength = mobInput.placeholder.length; 
					}
			    };
			    mobInput.placeholder = phoneData[selected_cc].example.replace(new RegExp(phoneData[selected_cc].pattern),phoneData[selected_cc].space);
			    mobInput.maxLength = mobInput.placeholder.length;
			    var keycode;
			    var fromPaste = false;
			    mobInput.addEventListener('keydown', function(e){
			    	keycode = e.keyCode;
			    	fromPaste = false;
			    });
			    mobInput.addEventListener('paste', function(e){
			    	fromPaste = true;
			    });
			    mobInput.addEventListener('input', function (e) {
					if(e.data == "."){//this if condition only for MAC machines
						e.target.value = obj.setSeperatedNumber(phoneData[selected_cc],obj.tempMobile);
						return false;
					}
			        var curPosition = e.target.selectionStart;
			        if((e.target.placeholder[curPosition] == " " || e.target.placeholder[curPosition] == "-" || e.target.placeholder[curPosition] == ".") && (keycode == 46)){
			        	e.target.value = e.target.value.slice(0, curPosition) + e.target.value.slice(curPosition+1);
			        }
			        if((e.target.placeholder[curPosition] == " " || e.target.placeholder[curPosition] == "-" || e.target.placeholder[curPosition] == ".") && (keycode == 8)){
			        	e.target.value = e.target.value.slice(0, curPosition-1) + e.target.value.slice(curPosition);
			        }
			        e.target.value = e.target.value.slice(0, e.target.placeholder.length).replace(/[^0-9]/gi, "");
			        e.target.value = obj.setSeperatedNumber(phoneData[selected_cc],e.target.value);
			        if(curPosition <= e.target.value.length && this.maxLength != e.target.value.length){
			            if((e.target.value[curPosition-1] == " " || e.target.value[curPosition-1] == "-" || e.target.value[curPosition-1] == ".")&& (keycode != 8 && keycode != 46) && (obj.isNumeric(e.data))){
			                curPosition = curPosition+1;
			            }
			            else if(((e.target.placeholder[curPosition] == " " || e.target.placeholder[curPosition] == "-" || e.target.placeholder[curPosition] == ".") && (keycode == 8))){
			            	curPosition = curPosition-1;
			            }
			            else if((!obj.isNumeric(e.data)) && (keycode != 8 && keycode != 46) && fromPaste == false){
			            	curPosition = curPosition-1;
			            }
			        }
			        else{
			            curPosition = e.target.value.length;
			        }
		        	e.target.selectionStart = curPosition;
		        	e.target.selectionEnd = curPosition;
		        	obj.tempMobile = e.target.value.replace(/[^\d\+]/g,"");
		        	if(obj.mobileNumber!=undefined && obj.tempMobile!=undefined &&(obj.tempMobile.length > obj.mobileNumber.length))
		        	{
						obj.mobileNumber = e.target.value.replace(/[^\d\+]/g,""); 	
					}	        	
			    });
			    if(mobileNo){
			    	mobInput.value = obj.setSeperatedNumber(phoneData[selected_cc],mobileNo);
			    }
		    }
		    else{
		    		if(mobileNo){mobInput.value = mobileNo;}
		    		if(mobInput.getAttribute("oninput")) {
						mobInput.setAttribute("oninput",mobInput.getAttribute("oninput")+",phonePattern.checkOnlyNumbers(this)");
					} else {
		    			mobInput.setAttribute("oninput","phonePattern.checkOnlyNumbers(this)");
					}
			}
		    		
		}
		obj.checkOnlyNumbers= function(element){
			element.value=element.value.replace(/[^+\d]+/g,'');
		}
		obj.setSeperatedNumber = function(data,number){
		    var value = data.example.replace(new RegExp(data.pattern),data.space).split("");
		    var num_count = 0;
		    for(var i=0;i<value.length;i++){
		        if(value[i] != " " && value[i] != "-" && value[i] != "."){
		            if(number[num_count]){
		                value[i] = number[num_count];
		            }
		            else{
		                num_count =i;
		                break;
		            }
		            if(i==value.length-1){
		                num_count =i;
		            }
		            num_count++;
		        }
		    }
		    value = value.slice(0,num_count).join("");
		    if(value[value.length-1] == " " || value[value.length-1] == "-" || value[value.length-1] == "."){
		       value = value.slice(0,value.length-1);
		    }
		    return value;
		}
		obj.isNumeric = function(obj){
			var reg = /^\d+$/;
			return reg.test(obj);
		}
		obj.intialize = function(selectEle,mobileNo,selectEvent){
			obj.mobileNumber = obj.tempMobile = undefined;
			obj.setMobileNumPlaceholder(selectEle,mobileNo,selectEvent);
			obj.tempMobile = mobileNo;
		}
		obj.destroy = function(selectEle){
			var mobInput = obj.findSiblingWithInputTypeTel(selectEle);
			mobInput.removeAttribute("maxlength");
			mobInput.replaceWith(mobInput.cloneNode(true));
		}
		obj.findSiblingWithInputTypeTel = function(selectEle){
			var mobInput = selectEle.nextElementSibling;
			while(mobInput){
				if((mobInput != null &&mobInput.type == "tel") || (mobInput != null && mobInput.tagName === 'INPUT')){
					return mobInput;
				}
				mobInput = mobInput.nextElementSibling;
				if(mobInput == null){mobInput = selectEle.parentNode;}
			}
		}
		obj.getCountryCharCodeWithNumCode = function(numCode){
			var countryCharCode;
			for(var key in phoneData){
				if(phoneData[key].code === numCode){
					countryCharCode = key;
					break;
				}
			}
			return countryCharCode;
		}
		obj.setMobileNumFormat = function(mobileNum,countryCode){
			var givenMobileNum = mobileNum;
			if(countryCode){
				mobileNum = mobileNum.replace(/[ \-\.]/g,'');
				if(obj.isNumeric(countryCode)){
					countryCode = "+"+countryCode;
				}
				if(countryCode.indexOf("+") != -1) {
					countryCode = phonePattern.getCountryCharCodeWithNumCode(countryCode);
				}	
			}
			else {
				mobileNum = mobileNum.replace(/[()]/g, '');
				if(mobileNum.split("")[0] === "+"){
					countryCode = mobileNum.split(" ")[0];
					mobileNum = mobileNum.split(" ")[1];
					countryCode = phonePattern.getCountryCharCodeWithNumCode(countryCode);
				}
				else{
					countryCode = phonePattern.getCountryCharCodeWithNumCode("+"+mobileNum.split('-')[0]);
					mobileNum = mobileNum.split('-')[1];
				}	
			}
			if(!countryCode){
				return givenMobileNum;
			}
			countryCode = countryCode.toUpperCase();
			if(phoneData[countryCode].example.length<mobileNum.length){
				return phoneData[countryCode].code+" "+mobileNum;
			}
			return phoneData[countryCode].code+" "+phonePattern.setSeperatedNumber(phonePattern.getCountryObj(countryCode),mobileNum);
		}
		return obj;
	}
};

var phonePattern = phonePatternClosure()();