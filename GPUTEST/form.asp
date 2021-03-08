<!doctype html>
<html lang="ko" data-dark="false">
<head>
<meta charset="utf-8">
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1190">
<meta name="apple-mobile-web-app-title" content=""/>
<meta name="robots" content="index,nofollow"/>
<meta name="description" content=""/>
<meta property="og:title" content="">
<meta property="og:url" content="">
<meta property="og:image" content="">
<meta property="og:description" content=""/>
<meta name="twitter:card" content=""> 
<meta name="twitter:title" content="">
<meta name="twitter:url" content="">
<meta name="twitter:image" content="">
<meta name="twitter:description" content=""/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>

<link rel="stylesheet" href="style.css">

<body>
<div class="box">
	<p class="question">경품 신청 페이지</p>
	<form method="POST"  name="myform">
		<div class="column" style="margin-top:30px;">
			<div class="field-wrapper" align="center">
				<input type="text" name="uname" class="form-email form-element large" placeholder="담당자 *"  >
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<input type="text" name="company" class="form-email form-element large" placeholder="회사명 *"  >
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<input type="text" name="number" class="form-email form-element large" placeholder="연락처 *"  >
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<input type="text" name="email" class="form-email form-element large" placeholder="이메일 *"  >
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<fieldset>
					<select name="business" id="business" class="form-element" onchange="showfield(this.options[this.selectedIndex].value)">
						<option selected="selected">업종 선택</option>
						<option value="농업, 임업 및 어업">농업, 임업 및 어업</option>
						<option value="제조업">제조업</option>
						<option value="건설업">건설업</option>
						<option value="도매 및 소매업">도매 및 소매업</option>
						<option value="운수 및 창고업">운수 및 창고업</option>
						<option value="정보통신업">정보통신업</option>
						<option value="금융 및 보험업">금융 및 보험업</option>
						<option value="부동산업">부동산업</option>
						<option value="전문, 과학 및 기술서비스업">전문, 과학 및 기술서비스업</option>
						<option value="사업시설 관리, 지원 서비스업">사업시설 관리, 지원 서비스업</option>
						<option value="공공행정, 국방 및 사회보장 행정">공공행정, 국방 및 사회보장 행정</option>
						<option value="교육서비스">교육서비스</option>
						<option value="보건업 및 사회복지">보건업 및 사회복지</option>
						<option value="예술, 스포츠 서비스업">예술, 스포츠 서비스업</option>
						<option value="국제 및 외국기관">국제 및 외국기관</option>
						<option value="기타">직접입력:</option>
					</select>
					<div id="div1"></div>
				</fieldset>
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<fieldset>
					<legend>퀴즈는 쉬웠나요?</legend>
						<p style="width:33.3%"><label class="choice"> <input type="radio" name="difficulty"  value="쉬움"> 쉬움 </label></p>
						<p style="width:33.3%"><label class="choice"> <input type="radio" name="difficulty"  value="보통"> 보통 </label></p>
						<p style="width:33.3%"><label class="choice"> <input type="radio" name="difficulty"  value="어려움"> 어려움 </label></p>
				</fieldset>
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<fieldset>
					<legend>추가자료를 이메일로 받아보시겠습니까?</legend>
						<p style="width:33.3%"><label class="choice"> <input type="checkbox" name="addinforeq" value="GPU"> A100 GPU </label></p>
						<p style="width:33.3%"><label class="choice"> <input type="checkbox" name="addinforeq" value="DGX"> DGX A100 </label></p>
						<p style="width:33.3%"><label class="choice"> <input type="checkbox" name="addinforeq" value="Station"> DGX Station </label></p>
						<p style="width:100%" class="m-t-15">
							<div style="float:left;width:20%;height:42px;line-height:42px;">기타</div><div style="float:left;width:80%;"><label class="choice"> <input type="text" name="addinforeq" value="" class="form-element"></label></div>
						</p>
				</fieldset>
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<fieldset>
					<legend>영업 담당자와 추가 상담이 필요하신가요?</legend>
					<p style="width:50%"><label class="choice"> <input type="radio" name="counsellingreq"  value="영업상담 필요"> 예 </label></p>
					<p style="width:50%"><label class="choice"> <input type="radio" name="counsellingreq"  value="영업상담 불필요"> 아니요 </label></p>
				</fieldset>
			</div>	
		</div>
		<div class="column">
			<div class="field-wrapper" align="center">
				<fieldset>
					<legend>추가 요청사항</legend>
					<textarea name="request2" maxlength="500" class="txt-element"></textarea>				
				</fieldset>
			</div>	
		</div>
		<div class="column" style="margin-top:15px;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tb">
				<tr>
					<th width="33.3%">수집 및 이용목적</th>
					<th width="33.3%">수집항목</th>
					<th>보유/이용 기간</th>
				</tr>
				<tr>
					<td>온라인 상담/견적</td>
					<td>성명, 회사명, 연락처, 이메일</td>
					<td>3년</td>
				</tr>
			</table>
			<div style="width:100%;padding:10px 0">소비자의 불만 또는 분쟁 처리에 관한 기록(전자상거래 등에서의 소비자보호에 관한 법률)</div>
			<div style="width:100%;padding:10px 0;"><input type="checkbox" name="agree" style="margin-right:10px;">개인정보 수집 및 이용에 동의합니다(필수)</div>
		</div>
		<div class="column" style="margin-bottom:30px">
			<a href="javascript:survey_send(document.myform);" class="btn">보내기</a>
		</div>
	</form>

	<div class="form-response"></div>
	<div class="banWrap">
		<ul>
			<li><a href="http://www.krinfra.co.kr/product/product_40.asp" target="_blank"><img src="images/ban_01.png" alt=""></a></li>
			<li><a href="http://www.krinfra.co.kr/product/product_46.asp" target="_blank"><img src="images/ban_02.png" alt=""></a></li>
			<li><a href="http://www.krinfra.co.kr/a100/#inception" target="_blank"><img src="images/ban_03.png" alt=""></a></li>
			<li><a href="http://www.krinfra.co.kr/a100/#lease" target="_blank"><img src="images/ban_04.png" alt=""></a></li>
			<li><a href="http://www.krinfra.co.kr/a100/gputest/requestform.asp" target="_blank"><img src="images/ban_05.png" alt=""></a></li>
		</ul>
	</div>
</div>


</body>
<script type="text/javascript" src="main.js"></script>
<script type="text/javascript">
	function showfield(name){
	if(name=='기타')document.getElementById('div1').innerHTML='<div style="float:left;width:20%;height:42px;line-height:42px;">기타</div><div style="float:left;width:80%;"><label class="choice"> <input type="text" name="addinforeq" value="" class="form-element"></label></div>';
	else document.getElementById('div1').innerHTML='';
}
</script>

</html>
