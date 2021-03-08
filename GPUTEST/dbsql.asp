<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<p>asdasd</p>
<!-- #include virtual= "/dbconn/config.asp" -->
<!-- #include virtual="/func/function.asp" -->
<% 


	Name					= CheckWord(request("uname"))
	Company					= CheckWord(request("company"))
	Number					= CheckWord(request("number"))
	Email					= CheckWord(request("email"))
	Difficulty				= CheckWord(request("difficulty"))
	AddInfoReq				= CheckWord(request("addinforeq"))
	Business				= CheckWord(request("business"))
	request2				= CheckWord(request("request2"))
	CounsellingReq			= CheckWord(request("counsellingreq"))



	SQL = "INSERT INTO A100_Survey (Name, Company, Number, Email, Difficulty, AddInfoReq, Business, Request, CounsellingReq) VALUES "
	SQL = SQL & "('" & Name & "'"		
	SQL = SQL & ",'" & Company & "'"
	SQL = SQL & ",'" & Number & "'"
	SQL = SQL & ",'" & Email & "'"
	SQL = SQL & ",'" & Difficulty & "'"
	SQL = SQL & ",'" & AddInfoReq & "'"
	SQL = SQL & ",'" & Business & "'"
	SQL = SQL & ",'" & request2 & "'"
	SQL = SQL & ",'" & CounsellingReq & "')"



	DbCon.Execute sql
	DbCon.Close

	pagego="http://www.krinfra.co.kr/A100/GPUTEST/"

%>

<SCRIPT LANGUAGE="JavaScript">
<!--
alert("사은품을 위한 설문조사를 완료하셨습니다.\n감사합니다~");
location.href="<%=pagego%>";
//-->
</SCRIPT>
