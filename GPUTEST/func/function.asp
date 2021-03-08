<%
'Dim sBASE_64_CHARACTERS, sBASE_64_CHARACTERSansi
sBASE_64_CHARACTERS	= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
sBASE_64_CHARACTERSansi	= strUnicode2Ansi(sBASE_64_CHARACTERS)


Function strUnicodeLen(asContents)
	Dim asContents1	: asContents1 ="a"	& asContents
	Dim Len1		: Len1=Len(asContents1)
	Dim K		: K=0
	Dim I, Asc1
	
	For I=1 To Len1
		Asc1	= asc(mid(asContents1,I,1))
		IF Asc1 < 0 Then Asc1	= 65536 + Asc1
		IF Asc1 > 255 Then
			K	= K + 2
		ELSE
			K	= K + 1
		End IF
	Next
	
	strUnicodeLen = K - 1
End Function

Function strUnicode2Ansi(asContents)
	Dim Len1			: Len1 = Len(asContents)
	Dim I, VarCHAR, VarASC, VarHEX, VarLOW, VarHIGH

	strUnicode2Ansi	= ""
	
	For I = 1 to Len1
		VarCHAR	= Mid(asContents,I,1)
		VarASC	= Asc(VarCHAR)
		IF VarASC < 0 Then VarASC = VarASC + 65536
		IF VarASC > 255 Then
			VarHEX		= Hex(VarASC)
			VarLOW		= Left(VarHEX,2)
			VarHIGH		= Right(VarHEX,2)
			strUnicode2Ansi	= strUnicode2Ansi & ChrB("&H" & VarLOW ) & ChrB("&H" & VarHIGH )
		Else
			strUnicode2Ansi	= strUnicode2Ansi & ChrB(VarASC)
		End IF
	Next
End Function



Function strAnsi2Unicode(asContents)
	Dim Len1			: Len1		= LenB(asContents)
	Dim VarCHAR, VarASC, I
'
	strAnsi2Unicode	= ""
	
	IF Len1=0 Then	Exit Function
	
	For I=1 To Len1
		VarCHAR	= MidB(asContents,I,1)
		VarASC	= AscB(VarCHAR)
		IF VarASC > 127 Then
			strAnsi2Unicode	= strAnsi2Unicode & Chr(AscW(MidB(asContents, I+1,1) & VarCHAR))
			I		= I + 1
		Else
			strAnsi2Unicode	= strAnsi2Unicode & Chr(VarASC)
		End IF
	Next
	
End function

Function Base64encode(asContents)
	Dim lnPosition
	Dim lsResult
	Dim Char1
	Dim Char2
	Dim Char3
	Dim Char4
	Dim Byte1
	Dim Byte2
	Dim Byte3
	Dim SaveBits1
	Dim SaveBits2
	Dim lsGroupBinary
	Dim lsGroup64
	Dim M3, M4, Len1, Len2

	Len1			=LenB(asContents)
	
	IF Len1 < 1 Then
		Base64encode	= ""
		Exit Function
	End IF

	M3=Len1 Mod 3
	
	IF M3 > 0 Then asContents = asContents & String(3 - M3, ChrB(0))

	IF m3 > 0 Then
		Len1	= Len1 + (3 - M3)
		Len2	= Len1 - 3
	Else
		Len2	= Len1
	End IF

	lsResult	= ""

	For lnPosition = 1 To Len2 Step 3
		lsGroup64	= ""
		lsGroupBinary	= MidB(asContents, lnPosition, 3)

		Byte1		= AscB(MidB(lsGroupBinary, 1, 1))	: SaveBits1	= Byte1 And 3
		Byte2		= AscB(MidB(lsGroupBinary, 2, 1))	: SaveBits2	= Byte2 And 15
		Byte3		= AscB(MidB(lsGroupBinary, 3, 1))
		Char1		= MidB(sBASE_64_CHARACTERSansi, ((Byte1 And 252) \ 4) + 1, 1)
		Char2		= MidB(sBASE_64_CHARACTERSansi, (((Byte2 And 240) \ 16) Or (SaveBits1 * 16) And &HFF) + 1, 1)
		Char3		= MidB(sBASE_64_CHARACTERSansi, (((Byte3 And 192) \ 64) Or (SaveBits2 * 4) And &HFF) + 1, 1)
		Char4		= MidB(sBASE_64_CHARACTERSansi, (Byte3 And 63) + 1, 1) 
		lsGroup64	= Char1 & Char2 & Char3 & Char4

		lsResult		= lsResult & lsGroup64
	Next

	IF M3 > 0 Then
		lsGroup64	= ""
		lsGroupBinary	= MidB(asContents, Len2 + 1, 3)

		Byte1		= AscB(MidB(lsGroupBinary, 1, 1))	: SaveBits1	= Byte1 And 3
		Byte2		= AscB(MidB(lsGroupBinary, 2, 1))	: SaveBits2	= Byte2 And 15
		Byte3		= AscB(MidB(lsGroupBinary, 3, 1))
		Char1		= MidB(sBASE_64_CHARACTERSansi, ((Byte1 And 252) \ 4) + 1, 1)
		Char2		= MidB(sBASE_64_CHARACTERSansi, (((Byte2 And 240) \ 16) Or (SaveBits1 * 16) And &HFF) + 1, 1)
		Char3		= MidB(sBASE_64_CHARACTERSansi, (((Byte3 And 192) \ 64) Or (SaveBits2 * 4) And &HFF) + 1, 1)

		IF M3=1 Then
			lsGroup64	= Char1 & Char2 & ChrB(61) & ChrB(61)
		Else
			lsGroup64	= Char1 & Char2 & Char3 & ChrB(61)
		End IF

		lsResult		= lsResult & lsGroup64
	End IF

	Base64encode = lsResult
End Function

Function Base64decode(asContents)
	Dim lsResult
	Dim lnPosition
	Dim lsGroup64, lsGroupBinary
	Dim Char1, Char2, Char3, Char4
	Dim Byte1, Byte2, Byte3
	Dim M4, Len1, Len2

	Len1	= LenB(asContents)
	M4	= Len1 Mod 4

	IF Len1 < 1 Or M4 > 0 Then
		Base64decode = ""
		Exit Function
	End IF

	IF MidB(asContents, Len1, 1) = ChrB(61) Then	M4 = 3
	IF MidB(asContents, Len1-1, 1) = ChrB(61) Then	M4 = 2

	IF M4 = 0 Then
		Len2	= Len1
	Else
		Len2	= Len1 - 4
	End IF

	For lnPosition = 1 To Len2 Step 4
		lsGroupBinary	= ""
		lsGroup64	= MidB(asContents, lnPosition, 4)

		Char1		= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 1, 1)) - 1
		Char2		= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 2, 1)) - 1
		Char3		= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 3, 1)) - 1
		Char4		= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 4, 1)) - 1

		Byte1		= ChrB(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF)
		Byte2		= lsGroupBinary & ChrB(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF)
		Byte3		= ChrB((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63))
		lsGroupBinary	= Byte1 & Byte2 & Byte3

		lsResult		= lsResult & lsGroupBinary
	Next

	IF M4 > 0 Then
		lsGroupBinary	= ""
		lsGroup64	= MidB(asContents, Len2 + 1, M4) & ChrB(65)
		IF M4=2 Then
			lsGroup64	= lsGroup64 & chrB(65)
		End IF
		Char1	= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 1, 1)) - 1
		Char2	= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 2, 1)) - 1
		Char3	= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 3, 1)) - 1
		Char4	= InStrB(sBASE_64_CHARACTERSansi, MidB(lsGroup64, 4, 1)) - 1

		Byte1	= ChrB(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF)
		Byte2	= lsGroupBinary & ChrB(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF)
		Byte3	= ChrB((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63))

		IF M4=2 Then
			lsGroupBinary	= Byte1
		elseIF M4=3 Then
			lsGroupBinary	= Byte1 & Byte2
		end IF

		lsResult			= lsResult & lsGroupBinary
	End IF

	Base64decode			= lsResult
End Function


Function CheckWord(CheckValue)

    CheckValue = replace(CheckValue, "&" , "&amp;")
    CheckValue = replace(CheckValue, "<", "&lt;")
    CheckValue = replace(CheckValue, "|", "&#124;")
    CheckValue = replace(CheckValue, ">", "&gt;")
    CheckValue = replace(CheckValue, "'", "''")
    CheckValue = replace(CheckValue, "#", "")
    CheckWord=CheckValue

End Function

Function CheckWord2(CheckValue)
    CheckValue = replace(CheckValue, "'", "''")
    CheckWord2=CheckValue
End Function

Function CheckWord_br(CheckValue)
    CheckValue = Replace("<BR>", CheckValue, chr(13))
    CheckWord_br=CheckValue
End Function

Function CheckWord_br2(CheckValue)
    CheckValue = Replace(chr(13), CheckValue, "<BR>")
    CheckWord_br2=CheckValue
End Function


Function paging()
'맨앞으로 
	If page <> 1 Then 
		Response.Write "<a href='JavaScript:re_search(1)'>[처음으로]</a>&nbsp;" 
	Else
		Response.Write "[처음으로]&nbsp;"
	End If

		blockpage=Int((page-1)/10)*10+1 


	If blockpage = 1 Then 
		Response.Write "[이전10]&nbsp;&nbsp;" 
	Else 
	Response.Write "<a href='JavaScript:re_search("& blockpage-10 &")'>[이전10]</a>&nbsp;&nbsp;" 
	End If 
'페이지 	숫자
i = 1 
	Do Until i > 10 Or blockpage > pagecount
		If blockpage=int(page) Then 
			response.write "<B><font class='pagecall' color=#330099>["&blockpage&"]</font></B>&nbsp;&nbsp;"
	
		Else
			Response.Write "<a href='JavaScript:re_search("& blockpage &")'>["&blockpage&"]</a>&nbsp;&nbsp;"
		End If 

blockpage=blockpage+1 
i=i+1 
	Loop   

	If blockpage > PageCount Then 
		Response.Write "&nbsp;[다음10]&nbsp;"

	Else 
		Response.Write "<a href='JavaScript:re_search("& blockpage &")'>&nbsp;[다음10]</a>&nbsp;" 
	End If'

'맨뒤로
	If Cint(page) < Cint(PageCount) Then
		Response.Write "<a href='JavaScript:re_search("& PageCount &")'>[끝으로]</a>&nbsp;" 
	
	Else
		Response.Write "[끝으로]&nbsp;"
	End If

End Function


Function go_blank()
Response.Write "<SCRIPT LANGUAGE=JavaScript>self.close;</SCRIPT>" 

End Function


Function LenSubject(str)
	if isNULL(str) Then
	LenSubject = 0
	Exit Function
	End if
	ns = len(str)
	t = 0
	for si = 1 to ns
	s = mid(str, si, 1)
	a = asc(s)
	if ((a > 0) and (a < 127)) then
	t = t + 1
	else
	t = t + 2
	end if
	next
	LenSubject = t
End Function


'문자열길이계산
Function chrlen(str)
	chlen = 0
	For i = 1 To Len(str)
		If Asc(Mid(str, i, 1)) < 0 Then
		   chlen = chlen + 2
		Else
		   chlen = chlen + 1
		End If
	Next
	chrlen = chlen

End Function

' --------------------------------------------------------
' 문자열을 원하는 길이만큼 자르기
' --------------------------------------------------------
Function LeftCut(strString, intCut)

    dim intPos, chrTemp, strCut, intLength
    '문자열 길이 초기화
    intLength = 0
    intPos = 1

    '문자열 길이만큼 돈다
    do while ( intPos <= Len( strString ))

       '문자열을 한문자씩 비교한다
        chrTemp = ASC(Mid( strString, intPos, 1))

        if chrTemp < 0 then '음수값(-)이 나오면 한글임
          strCut = strCut & Mid( strString, intPos, 1 ) 
          intLength = intLength + 2  '한글일 경우 문자열 길이를 2를 더한다 
        else
          strCut = strCut & Mid( strString, intPos, 1 )            
          intLength = intLength + 1  '한글이 아닌경우 문자열 길이를 1을 더한다
        end If

        if intLength >= intCut  then
           exit do
        end if

        intPos = intPos + 1
  
    Loop

    '리턴값
	If chrlen(strString) > intCut Then
		LeftCut = strCut &".."
	Else
	    LeftCut = strCut
	End If

End Function


'//메일발송
Function mailsend(Requester,sender,senderMail,subject,contents)

Set objSendMail = CreateObject("CDONTS.NewMail")

'sender = strAnsi2Unicode(Base64encode(strUnicode2Ansi(sender)))
'sender = sender & "<"& senderMail &">"

With objSendMail
	'.To = "support@krinfra.co.kr"		
	.To = "webmaster@krinfra.co.kr"		
	.From =  "ohaa@ddd.com"
	.BodyFormat = 0
	.MailFormat = 0

		contents = Replace(contents, "&nbsp;", chr(32))
		contents = Replace(contents, chr(13), "<BR>")
		contents = Replace(contents, "&lt;","<")
		contents = Replace(contents, "&gt;",">")
		contents = Replace(contents, "&lt;BR&gt;", "<BR>")
		contents = Replace(contents, "&amp;", "&")

	.Subject = "jjj"
	.Body = "dddd"
	.Send
end with

Set objSendMail = nothing

END Function



Function setSendMail(remail, subject, sendmail, mailcontents, remailCC)
	
	mailcontents = replace(mailcontents,chr(10), "<br>")

	Set objConfig = Server.CreateObject("CDO.Configuration")

	  With objConfig.Fields
	   .item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
	   .item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\pickup"
	   .item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
	   .item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
	   .update
	  End With

	  Set objMessage = Server.CreateObject("CDO.Message")

	  With objMessage
	  Set .Configuration = objConfig
	   .Subject = subject
	   .From=sendmail
	   .To=remail

		If remailCC <> "" Then
	   .CC=remailCC
		End If 
	   
	   .HTMLBody = mailcontents
	   .Send
	End With		
		

	Set objConfig = nothing


END Function



Sub SendMailFromGmail(remail, subject, sendmail, mailcontents, remailCC)


    Set iMsg = CreateObject("CDO.Message")
    Set iConf = CreateObject("CDO.Configuration")

    iConf.Load -1
    Set Flds = iConf.Fields
    
     With Flds
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
        .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "krinfra@krinfra.co.kr"
        .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "1qaz2wsx!@#$!!"
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com" 'smtp mail server
        .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 'stmp server
        .Update
    End With

    With iMsg

        Set .Configuration = iConf
        .From = sendmail
		.To = remail

		If remailCC <> "" Then '참조자
		.Cc = remailCC
		End If

		If remailCC <> "" Then
		.CC=remailCC
		End If 

   
        .Subject = subject
        .HTMLBody  = mailcontents
        .Send
    End With

    Set iMsg = Nothing
    Set iConf = Nothing

End Sub



Function rndPasswd(intPassLength)
  Dim araChars(33) '암호에 사용될 문자들을 저장할 배열 생성
  araChars(0) = "A"
  araChars(1) = "B"
  araChars(2) = "C"
  araChars(3) = "D"
  araChars(4) = "E"
  araChars(5) = "F"
  araChars(6) = "G"
  araChars(7) = "H"
  araChars(8) = "J"
  araChars(9) = "K"
  araChars(10) = "L"
  araChars(11) = "M"
  araChars(12) = "N"
  araChars(13) = "P"
  araChars(14) = "Q"
  araChars(15) = "R"
  araChars(16) = "S"
  araChars(17) = "T"
  araChars(18) = "U"
  araChars(19) = "V"
  araChars(20) = "W"
  araChars(21) = "X"
  araChars(22) = "Y"
  araChars(23) = "Z"
  araChars(26) = "2"
  araChars(28) = "3"
  araChars(29) = "4"
  araChars(30) = "5"
  araChars(31) = "6"
  araChars(32) = "8"
  araChars(33) = "9"

  strPassword = ""
  Randomize
  Do Until Len(strPassword) = intPassLength
  strPassword = strPassword &""& araChars(int(rnd()*33))
  Loop
  rndPasswd = strPassword
 End Function


%>
