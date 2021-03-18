<!-- #include virtual= "/dbconn/config.asp" -->
<!-- #include virtual="/func/function.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<%
Response.Expires = 0
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=NVIDIA퀴즈_설문자료.xls"


	SQL = "SELECT * FROM A100_Survey"
	Set rs = DbCon.execute(sql)

%>

<table border=1>
  <tr>
    <td width=40  bgcolor=#F2F2F2><b>No.</b></td>
    <td width=200  bgcolor=#F2F2F2><b>접수날짜</b></td>
    <td width=80  bgcolor=#F2F2F2><b>이름</b></td>
    <td width=120  bgcolor=#F2F2F2><b>회사</b></td>
    <td width=150  bgcolor=#F2F2F2><b>직종</b></td>
    <td width=150  bgcolor=#F2F2F2><b>연락처</b></td>
    <td width=200  bgcolor=#F2F2F2><b>이메일</b></td>
    <td width=150  bgcolor=#F2F2F2><b>추가자료요청</b></td>
    <td width=300  bgcolor=#F2F2F2><b>요청사항</b></td>
    <td width=130  bgcolor=#F2F2F2><b>영업상담요청</b></td>
  </tr>

<%      
IF  rs.eof THEN  
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
ELSE
Do until rs.eof 
	RegisterNum = Trim(rs("RegisterNum")) '번호
	RegDate = Trim(rs("RegDate")) '등록일
	Name = Trim(rs("Name")) '이름
	Company =Trim(rs("Company")) '회사명
	Business = Trim(rs("Business")) '직종
	Contact =Trim(rs("Number")) '전화번호
	Email = Trim(rs("Email")) '이메일
	AddInfoReq =Trim(rs("AddInfoReq")) '추가자료요청
	InforReq = Trim(rs("Request")) '추가요청
	CounsellingReq = Trim(rs("CounsellingReq")) '영업요청
%>

<tr >
	<td style='mso-number-format:"\@";'><%=RegisterNum%></td>
	<td style='mso-number-format:"\@";'><%=RegDate%></td>
	<td style='mso-number-format:"\@";'><%=Name%></td>
	<td style='mso-number-format:"\@";'><%=Company%></td>
	<td style='mso-number-format:"\@";'><%=Business%></td>
	<td style='mso-number-format:"\@";'><%=Contact%></td>
	<td style='mso-number-format:"\@";'><%=Email%></td>
	<td style='mso-number-format:"\@";'><%=AddInfoReq%></td>
	<td style='mso-number-format:"\@";'><%=InforReq%></td>
	<td style='mso-number-format:"\@";'><%=CounsellingReq%></td>
</tr>
    
<%      
  rs.MoveNext 
  Loop
  END IF
%>
</table>
