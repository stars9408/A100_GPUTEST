<!--METADATA TYPE= "typelib"  NAME= "ADODB Type Library"
      FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"  -->

<%


	' 이 파일은 매직보드 환경 설정 파일입니다.
	' 이 파일은 임의대로 수정이 가능하나 DB의 연결이 잘못될 수 있습니다. 
	' *******GIT 업로드를 위해 PASSWORD와 IP를 임의로 수정하였습니다.*******'

	home_dir1        = "http://www.krinfra.co.kr/"
	home_dir2        = "E:\web\krinfra\"

	Db_Odbc_Name     = "www"
	
	Db_Odbc_Name_edu     = "edu"

	Db_Odbc_Name_callreport     = "callreport"

	Db_Odbc_User     = "wwwadmin"
	Db_Odbc_Pass     = "PASSWORD"

	Db_Odbc_Call_User     = "asc"
	Db_Odbc_Call_Pass     = "asckrinfra"

	sql_ip = "192.168.xxx.xxx"
	SendServerIP = "192.168.xxx.xxx:23569"
	joinip = Request("REMOTE_ADDR") 

	mail_component   = "1"
	upload_component = "2" '1 ABC 업로드 '2 DEXT 업로드	                       

	upload_path = "E:\WEB\krinfra\purchase\excel"
	fileDir = "/download/"
	home_dir3 = "http://www.krinfra.co.kr"

	' DB 에 연결을 부분
	DbConnect = "Provider=SQLOLEDB;Data Source = "&sql_ip&";Initial Catalog="&Db_Odbc_Name&";User ID="&Db_Odbc_User&";Password="&Db_Odbc_Pass&";"

	SET DbCon = Server.CreateObject("ADODB.Connection")
	DbCon.Open DbConnect


	'Call DB 에 연결을 부분
	DbConnect_call = "Provider=SQLOLEDB;Data Source = "&sql_ip&";Initial Catalog="&Db_Odbc_Name_callreport&";User ID="&Db_Odbc_Call_User&";Password="&Db_Odbc_Call_Pass&";"

	SET DbConCall = Server.CreateObject("ADODB.Connection")
	DbConCall.Open DbConnect_call

	' Edu DB 에 연결을 부분
	DbConnect_edu = "Provider=SQLOLEDB;Data Source = "&sql_ip&";Initial Catalog="&Db_Odbc_Name_edu&";User ID="&Db_Odbc_User&";Password="&Db_Odbc_Pass&";"

	SET DbCon_edu = Server.CreateObject("ADODB.Connection")
	DbCon_edu.Open DbConnect_edu


%>