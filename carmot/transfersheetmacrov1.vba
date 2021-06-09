Private Sub transfers_Click()
' Create Transfer Sheet Sheet if it doesn't exist

Dim wsTest As Worksheet
Const strSheetName As String = "Transfer Sheet"
 
Set wsTest = Nothing
On Error Resume Next
Set wsTest = ActiveWorkbook.Worksheets(strSheetName)
On Error GoTo 0

If wsTest Is Nothing Then
 Worksheets.Add(After:=Sheets(Sheets.Count)).Name = strSheetName
 ActiveWorkbook.Sheets(strSheetName).Cells(1, 1) = "Source Plate Barcode"
 ActiveWorkbook.Sheets(strSheetName).Cells(1, 2) = "Source Well"
 ActiveWorkbook.Sheets(strSheetName).Cells(1, 3) = "Destination Plate Barcode"
 ActiveWorkbook.Sheets(strSheetName).Cells(1, 4) = "Destination Well"
 ActiveWorkbook.Sheets(strSheetName).Cells(1, 5) = "Transfer Volume"
End If
Worksheets("src").Activate
' iterate through rows until blank, appending to transfer sheet
Set sh = ActiveSheet
For Each rw In sh.Rows
    If rw.Row = 1 Then GoTo continue
    
  If sh.Cells(rw.Row, 1).Value = "" Then
    Exit For
  End If

    Set ts = ActiveWorkbook.Sheets(strSheetName)

    

    Set sfirst = sh.Cells(rw.Row, 2)

    Set slast = Cells(rw.Row, 3)
    Set destp = Cells(rw.Row, 4)
    Set dfirst = Cells(rw.Row, 5)
    Set Dlast = Cells(rw.Row, 6)
    Set vol = Cells(rw.Row, 7)
    Set sourcep = Cells(rw.Row, 1)

    If Left(sfirst, 1) = Left(slast, 1) Then
        sourceChar = Left(sfirst, 1)
        destChar = Left(dfirst, 1)
    ' iterate over cols into transfer sheet
        tmp = Mid(sfirst.Value, 2, Len(sfirst.Value))
        fidx = CInt(tmp)
        tmp = Mid(slast.Value, 2, Len(slast.Value))
        eidx = CInt(tmp)
        destidx = CInt(Mid(dfirst, 2, Len(dfirst)))
        For i = fidx To eidx
            For Each trw In ts.Rows

                If ts.Cells(trw.Row, 1).Value = "" Then
                ts.Cells(trw.Row, 1).Value = sourcep
                ts.Cells(trw.Row, 2).Value = sourceChar + CStr(i)
                ts.Cells(trw.Row, 3).Value = destp
                ts.Cells(trw.Row, 4).Value = destChar + CStr(destidx)
                ts.Cells(trw.Row, 5).Value = vol
                Exit For
                End If

                
                
            Next trw
        destidx = destidx + 1
        Next i
    Else
        
    End If
    sh.Activate
        
For i = 1 To 7
    sh.Cells(rw.Row, i).Clear
Next i
    
continue:
Next rw
MsgBox ("Done!")
End Sub
