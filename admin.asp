<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta charset="utf-8">
<link rel="stylesheet" href="admincss.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- #include virtual= "/dbconn/config.asp" -->
<!-- #include virtual="/func/function.asp" -->


<% 

	pagego="admin.asp"
	db_board_name="A100_Survey"

	reqDate1 = Replace(request("reqDate1")," ","")
	reqDate2 = Replace(request("reqDate2")," ","")

	totSql = "SELECT COUNT(RegisterNum) FROM A100_Survey WHERE 1 = 1"  
	totWeekSql = "SELECT COUNT(RegisterNum) FROM A100_Survey WHERE RegDate >=" & dtsvalue & ""  
	
	If reqDate1 <> "" Then '날짜
		reqDateQuery =  "  and  CONVERT(CHAR(10), RegDate, 23) >= '"&reqDate1&"' and CONVERT(CHAR(10), RegDate, 23)  <= '"&reqDate2&"' " 
	End If

	If reqDate1 <> "" then
		whereadd = reqDateQuery 
	End If

	IF whereadd = "" Then
		SQL = "SELECT * FROM A100_Survey"
	Else
		SQL = "SELECT * FROM A100_Survey WHERE 1 = 1 " & whereadd & ""
	END If
	Response.write(sql)
	Set rs = DbCon.execute(sql)
	Set rs2= DbCon.execute(totSql)
	
	'현재시각 계산 YYYY-MM-DD HH:MM:SS
	Dim dd, mm, yy, hh, nn, ss
	Dim datevalue, timevalue, dtsnow, dtsvalue

	dtsnow = Now()

	dd = Right("00" & Day(dtsnow), 2)
	mm = Right("00" & Month(dtsnow), 2)
	yy = Year(dtsnow)
	hh = Right("00" & Hour(dtsnow), 2)
	nn = Right("00" & Minute(dtsnow), 2)
	ss = Right("00" & Second(dtsnow), 2)

	'Build the date string in the format yyyy-mm-dd
	datevalue = yy & "-" & mm & "-" & dd
	'Build the time string in the format hh:mm:ss
	timevalue = hh & ":" & nn & ":" & ss
	'Concatenate both together to build the timestamp yyyy-mm-dd hh:mm:ss
	dtsvalue = datevalue & " " & TimeValue

	totWeekSql = "SELECT COUNT(RegisterNum) FROM A100_Survey WHERE RegDate >= DATEADD(hh, -168, GETDATE())"
	Set rs3= DbCon.execute(totWeekSql)
%>
<html>
<body>
	<div class="section">
	<br><br>
		<h1 class="pageTit"><i class="fas fa-angle-double-right"></i>NVIDIA A100 퀴즈 설문 집계 정보</h1> 
		<div style="text-align: center;">
		<br><br>
			<span>	
			<div class="search-sec">
				<form name="list_form" action="<%=pagego%>">
				<label><i class="fas fa-angle-right"></i>날짜</label>
				<input type="date" name="reqDate1" id="reqDate1"  class="btnCalendar basic_val" style="width:150px" value="<%=reqDate1%>"/>
				<span>~</span>
				<input type="date" name="reqDate2" id="reqDate2"  class="btnCalendar basic_val" style="width:150px"  value="<%=reqDate2%>"/>
				<a href="javascript:search();" id="btnSearch" class="btn-basic d-gray" /><i class="fas fa-search"></i>찾기</a>
				<a href="admin.asp" id="btnReset" class="btn-basic d-gray">전체보기</a> 
			</div>
				<table>
					<tr>
						<td style="width:400px;">현재 시간 : <span id="clock"></span><br></td>
						<td>검색 시간: <span><%=dtsvalue%></span><br></td>
						<td>[최근 7일: <span><%= Response.write(rs3(0))%>개]</span><br></td>
						<td>[누적 총 : <span><%= Response.write(rs2(0))%>개]</span></td>
						<td><div class="buttons"> <div class="container"><a href="excel.asp" class="btn effect01" target="_blank"><span>Excel Download</span></a></div></div></td>
					<tr>
				</table>
			</span>
			<!--<span>
				<a href="excel.asp" class="btn-basic d-gray"><i class="fas fa-file-excel"></i>엑셀 받기</a>
				<input type="button" class="fa btn_t02 btnBlueLine" value="&#xf1c3 엑셀다운로드" onClick="javascript:location.href('excel.asp')">
			</span> 
			-->
		</div>

		<br><br>
		<table id="information" cellspacing="0" cellpadding="0" border="0" class="tbBasic">
			<tr>
				<th width="30px">No.</th>
				<th width="100px">접수날짜</th>
				<th width="80px">이름</th>
				<th width="140px">회사</th>
				<th width="140px">직종</th>
				<th width="120px">연락처</th>
				<th width="130px">이메일</th>
				<th width="110px">추가자료요청</th>
				<th width="220px">요청사항</th>
				<th width="60px">영업상담요청</th>
			</tr>

<%
	
	IF Rs.EOF THEN
%>
		<tr>
			<td colspan="11" style="text-align:center">데이타가 없습니다.</td>
		</tr>
<%
	Else  
	Do Until Rs.Eof	 

		RegisterNum		= rs("RegisterNum")
		Name			= rs("Name")
		Company			= rs("Company")
		Contact			= rs("Number")		
		Email			= rs("Email")		
		AddInfoReq		= rs("AddInfoReq")		
		Business		= rs("Business")
		InforReq		= rs("Request")
		RegDate			= rs("RegDate")
		CounsellingReq	= rs("CounsellingReq")

%> 
	<tr >
		<td><%=RegisterNum%></td>
		<td><%=RegDate%></td>
		<td><%=Name%></td>
		<td><%=Company%></td>
		<td><%=Business%></td>
		<td><%=Contact%></td>
		<td><%=Email%></td>
		<td><%=AddInfoReq%></td>
		<td><%=InforReq%></td>
		<td><%=CounsellingReq%></td>
	</tr>
<%      
	rs.MoveNext     
	Loop
	rs.close
	set rs= nothing
	set db= nothing
	end if

%>
	</table>


</div>
</body>
</html>
<script language="JavaScript">

	function printTime() {
		var clock = document.getElementById("clock");
		var now = new Date();
		clock.innerHTML = now.getFullYear() + "년 " + (now.getMonth()+1) + "월 " + now.getDate() + "일 " + now.getHours() + "시 " + now.getMinutes() + "분 " + now.getSeconds() + "초";
		setTimeout("printTime()", 1000); 
	} 

	window.onload = function() {
		printTime();
	}; 

	$("#btnSearch").click(function() {
		document.list_form.submit();
	});

	$("#btnReset").click(function() {
		$("reqDate1").val("");
		$("reqDate2").val("");
		document.list_form.submit();
	});
	
</script>
