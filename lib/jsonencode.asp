<script language="vbscript" runat="server">
'
'	VBS JSON 2.0.3
'	Copyright (c) 2009 Tuðrul Topuz
'	Under the MIT (MIT-LICENSE.txt) license.
'
Function JSONencode(str)
	Dim charmap(127), haystack()
	charmap(8)  = "\b"
	charmap(9)  = "\t"
	charmap(10) = "\n"
	charmap(12) = "\f"
	charmap(13) = "\r"
	charmap(34) = "\"""
	charmap(47) = "\/"
	charmap(92) = "\\"
	Dim strlen : strlen = Len(str) - 1
	ReDim haystack(strlen)

	Dim i, charcode
	For i = 0 To strlen
		haystack(i) = Mid(str, i + 1, 1)
		charcode = AscW(haystack(i)) And 65535
		If charcode < 127 Then
			If Not IsEmpty(charmap(charcode)) Then
				haystack(i) = charmap(charcode)
			ElseIf charcode < 32 Then
				haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
			End If
		Else
			haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
		End If
	Next
	JSONencode = Join(haystack, "")
End Function
</script>