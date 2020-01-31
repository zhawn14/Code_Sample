VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm1 
   Caption         =   "UserForm1"
   ClientHeight    =   10296
   ClientLeft      =   30
   ClientTop       =   360
   ClientWidth     =   19800
   OleObjectBlob   =   "Sheet_Parser.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "UserForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdExit_Click()
    End
End Sub

Private Sub cmdGenerate_Click()
    Dim y1 As Integer
    Dim y2 As Integer
    Dim y3 As Integer
    Dim n As Integer
    Dim i As Integer
    Dim j As Integer
    Dim out As Integer
    Dim val() As Integer
    Dim size As Integer
    Dim count1 As Integer
    Dim count2 As Integer
    Dim rang3 As Integer
    
    y1 = 2
    y2 = 2
    y3 = 1
    count1 = 0
    count2 = 0
    n = 2
    i = 1
    
    ''''''''''''''''''''''''''Sheet2->Sheet3'''''''''''''''''''''''''
    Do While (n <= Worksheets(2).Range("F1", Worksheets(2).Range("F1").End(xlDown)).Rows.Count)
        out = 0
        Do While (out <= 0)
            If Worksheets(2).Cells(n, 11) = Worksheets(2).Cells(n + i, 11) Then             'check CA #
                If Worksheets(2).Cells(n, 17) = Worksheets(2).Cells(n + i, 17) Then         'check doc #
                    For j = 1 To 20
                        If (Worksheets(2).Cells(n, j).Text = "") Then                       'check current value info
                        ElseIf (Worksheets(2).Cells(n, j).Text = "-") Then
                        Else
                            count1 = count1 + 1
                        End If
                        
                        If (Worksheets(2).Cells(n + i, j).Text = "") Then                   'check next value info
                        ElseIf (Worksheets(2).Cells(n + i, j).Text = "-") Then
                        Else
                            count2 = count2 + 1
                        End If
                    Next j
                Else
                    out = 1
                End If
                
                If (count1 < count2) Then
                    n = n + i
                    i = 1
                Else
                    i = i + 1
                End If
                    
                count1 = 0
                count2 = 0
            
            Else
                out = 1
                i = i + 1
            End If
        Loop
        
    y2 = n
    y3 = y3 + 1
    
    Worksheets(3).Cells(y3, 1) = Worksheets(2).Cells(y2, 1)                 'CR Name
    Worksheets(3).Cells(y3, 2) = Worksheets(2).Cells(y2, 2)                 'CR #
    Worksheets(3).Cells(y3, 3) = Worksheets(2).Cells(y2, 3)                 'CR XREF
    Worksheets(3).Cells(y3, 4) = Worksheets(2).Cells(y2, 4)                 'CR State
    Worksheets(3).Cells(y3, 5) = Worksheets(2).Cells(y2, 5)                 'CCB Date
    Worksheets(3).Cells(y3, 6) = Worksheets(2).Cells(y2, 6)                 'CN #
    
    If Worksheets(2).Cells(y2, 7) = "IMPLEMENTATION" Then                   'CIB Date, CN State
    ElseIf Worksheets(2).Cells(y2, 7) = "-" Then
    Else
        Worksheets(3).Cells(y3, 11) = Worksheets(2).Cells(y2, 7)
    End If
    
    If Worksheets(2).Cells(y2, 9) = "RESOLVED" Then                         'CIB Date, CN State, CA State, CA Completion
        Worksheets(3).Cells(y3, 12) = "Approved CN Stamped"
        Worksheets(3).Cells(y3, 18) = "Drawing Released"
        Worksheets(3).Cells(y3, 17) = Worksheets(2).Cells(y2, 19)
    ElseIf Worksheets(2).Cells(y2, 9) = "CANCELLED" Then
        Worksheets(3).Cells(y3, 11) = "N/A"
        Worksheets(3).Cells(y3, 12) = "Removed from CR"
        Worksheets(3).Cells(y3, 17) = "N/A"
        Worksheets(3).Cells(y3, 18) = "Removed from CR"
    ElseIf Worksheets(2).Cells(y2, 9) = "IMPLEMENTATION" Then
        Worksheets(3).Cells(y3, 12) = "Approved CN Stamped"
        Worksheets(3).Cells(y3, 18) = (Worksheets(2).Cells(y2, 14) + ", " + Worksheets(2).Cells(y2, 15))
    Else
        Worksheets(3).Cells(y3, 12) = (Worksheets(2).Cells(y2, 9) + ", " + Worksheets(2).Cells(y2, 10))
    End If
    
    Worksheets(3).Cells(y3, 13) = Worksheets(2).Cells(y2, 11)               'CA #
    Worksheets(3).Cells(y3, 14) = Worksheets(2).Cells(y2, 17)               'Drawing Name
    Worksheets(3).Cells(y3, 16) = Worksheets(2).Cells(y2, 18)               'Drawing #

    n = (n + i - 1)
    i = 1
    Loop
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    ''''''''''''''''''''''''''Sheet1->Sheet3'''''''''''''''''''''''''
    y1 = 2
    out = 0
    range3 = Worksheets(3).Range("F1", Worksheets(3).Range("F1").End(xlDown)).Rows.Count
    Do While (out <= 0)
    y3 = 2
    Do While (y3 <= range3)
        If (y1 <= Worksheets(1).Range("F1", Worksheets(1).Range("F1").End(xlDown)).Rows.Count) Then
            If (Worksheets(3).Cells(y3, 6) = Worksheets(1).Cells(y1, 6)) Then                       'CN Check
                If (Worksheets(3).Cells(y3, 13) = Worksheets(1).Cells(y1, 13)) Then                 'CA Check
                    If (Worksheets(3).Cells(y3, 14) = Worksheets(1).Cells(y1, 14)) Then             'Doc Check
                        Worksheets(3).Cells(y3, 19) = Worksheets(1).Cells(y1, 19)                   'Req. For FCWP
                        Worksheets(3).Cells(y3, 20) = Worksheets(1).Cells(y1, 20)                   'Milestone for Proc.
                        Worksheets(3).Cells(y3, 21) = Worksheets(1).Cells(y1, 21)                   'Build
                        Worksheets(3).Cells(y3, 22) = Worksheets(1).Cells(y1, 22)                   'FAT Test
                        Worksheets(3).Cells(y3, 23) = Worksheets(1).Cells(y1, 23)                   'EQT Test
                        Worksheets(3).Cells(y3, 24) = Worksheets(1).Cells(y1, 24)                   'INCO
                        Worksheets(3).Cells(y3, 25) = Worksheets(1).Cells(y1, 25)                   'SW Release
                        Worksheets(3).Cells(y3, 26) = Worksheets(1).Cells(y1, 26)                   'SW Test
                        Worksheets(3).Cells(y3, 27) = Worksheets(1).Cells(y1, 27)                   'SW Build
                        Worksheets(3).Cells(y3, 28) = Worksheets(1).Cells(y1, 28)                   'Equip. Avail.
                        Worksheets(3).Cells(y3, 29) = Worksheets(1).Cells(y1, 29)                   'Site Test
                        Worksheets(3).Cells(y3, 30) = Worksheets(1).Cells(y1, 30)                   'No Impact
                        Worksheets(3).Cells(y3, 31) = Worksheets(1).Cells(y1, 31)                   'Funct. Red. FCWP AEC
                        Worksheets(3).Cells(y3, 32) = Worksheets(1).Cells(y1, 32)                   'Funct. Red. FCWP BSC
                        Worksheets(3).Cells(y3, 33) = Worksheets(1).Cells(y1, 33)                   'Funct. Red. FCWP SCS
                        Worksheets(3).Cells(y3, 34) = Worksheets(1).Cells(y1, 34)                   'AEC CSI Red. FCWP
                        Worksheets(3).Cells(y3, 35) = Worksheets(1).Cells(y1, 35)                   'Lock Up Design Chg. Best Pract. FCWP AEC
                        Worksheets(3).Cells(y3, 36) = Worksheets(1).Cells(y1, 36)                   'Lock Up Design Chg. Best Pract. FCWP BSC
                        Worksheets(3).Cells(y3, 37) = Worksheets(1).Cells(y1, 37)                   'Chg. Best Pract. FCWP SCS
                        Worksheets(3).Cells(y3, 38) = Worksheets(1).Cells(y1, 38)                   'Chg. Red. AEC
                        Worksheets(3).Cells(y3, 39) = Worksheets(1).Cells(y1, 39)                   'Chg. Red. BSC
                        Worksheets(3).Cells(y3, 40) = Worksheets(1).Cells(y1, 40)                   'Chg. Red. SCS
                        Worksheets(3).Cells(y3, 41) = Worksheets(1).Cells(y1, 41)                   'Invert. FCWP 3977.
                        Worksheets(3).Cells(y3, 42) = Worksheets(1).Cells(y1, 42)                   'Invert. UIC FCWP
                        Worksheets(3).Cells(y3, 43) = Worksheets(1).Cells(y1, 43)                   'PCD FCWP
                        Worksheets(3).Cells(y3, 44) = Worksheets(1).Cells(y1, 44)                   'WT FCWP
                        
                        y1 = y1 + 1
                    End If
                End If
            End If
        Else
            out = 1
        End If
        
        If (y3 >= range3) Then
            y3 = y3 + 1
            range3 = y3
            
            Worksheets(3).Cells(y3, 1).Value = Worksheets(1).Cells(y1, 1).Value
            Worksheets(3).Cells(y3, 2).Value = Worksheets(1).Cells(y1, 2).Value
            Worksheets(3).Cells(y3, 3).Value = Worksheets(1).Cells(y1, 3).Value
            Worksheets(3).Cells(y3, 4).Value = Worksheets(1).Cells(y1, 4).Value
            Worksheets(3).Cells(y3, 5).Value = Worksheets(1).Cells(y1, 5).Value
            Worksheets(3).Cells(y3, 6).Value = Worksheets(1).Cells(y1, 6).Value
            Worksheets(3).Cells(y3, 7).Value = Worksheets(1).Cells(y1, 7).Value
            Worksheets(3).Cells(y3, 8).Value = Worksheets(1).Cells(y1, 8).Value
            Worksheets(3).Cells(y3, 9).Value = Worksheets(1).Cells(y1, 9).Value
            Worksheets(3).Cells(y3, 10).Value = Worksheets(1).Cells(y1, 10).Value
            Worksheets(3).Cells(y3, 11).Value = Worksheets(1).Cells(y1, 11).Value
            Worksheets(3).Cells(y3, 12).Value = Worksheets(1).Cells(y1, 12).Value
            Worksheets(3).Cells(y3, 13).Value = Worksheets(1).Cells(y1, 13).Value
            Worksheets(3).Cells(y3, 14).Value = Worksheets(1).Cells(y1, 14).Value
            Worksheets(3).Cells(y3, 15).Value = Worksheets(1).Cells(y1, 15).Value
            Worksheets(3).Cells(y3, 16).Value = Worksheets(1).Cells(y1, 16).Value
            Worksheets(3).Cells(y3, 17).Value = Worksheets(1).Cells(y1, 17).Value
            Worksheets(3).Cells(y3, 18).Value = Worksheets(1).Cells(y1, 18).Value
            Worksheets(3).Cells(y3, 19).Value = Worksheets(1).Cells(y1, 19).Value                   'Req. For FCWP
            Worksheets(3).Cells(y3, 20).Value = Worksheets(1).Cells(y1, 20).Value                   'Milestone for Proc.
            Worksheets(3).Cells(y3, 21).Value = Worksheets(1).Cells(y1, 21).Value                   'Build
            Worksheets(3).Cells(y3, 22).Value = Worksheets(1).Cells(y1, 22).Value                   'FAT Test
            Worksheets(3).Cells(y3, 23).Value = Worksheets(1).Cells(y1, 23).Value                   'EQT Test
            Worksheets(3).Cells(y3, 24).Value = Worksheets(1).Cells(y1, 24).Value                   'INCO
            Worksheets(3).Cells(y3, 25).Value = Worksheets(1).Cells(y1, 25).Value                   'SW Release
            Worksheets(3).Cells(y3, 26).Value = Worksheets(1).Cells(y1, 26).Value                   'SW Test
            Worksheets(3).Cells(y3, 27).Value = Worksheets(1).Cells(y1, 27).Value                   'SW Build
            Worksheets(3).Cells(y3, 28).Value = Worksheets(1).Cells(y1, 28).Value                   'Equip. Avail.
            Worksheets(3).Cells(y3, 29).Value = Worksheets(1).Cells(y1, 29).Value                   'Site Test
            Worksheets(3).Cells(y3, 30).Value = Worksheets(1).Cells(y1, 30).Value                   'No Impact
            Worksheets(3).Cells(y3, 31).Value = Worksheets(1).Cells(y1, 31).Value                   'Funct. Red. FCWP AEC
            Worksheets(3).Cells(y3, 32).Value = Worksheets(1).Cells(y1, 32).Value                   'Funct. Red. FCWP BSC
            Worksheets(3).Cells(y3, 33).Value = Worksheets(1).Cells(y1, 33).Value                   'Funct. Red. FCWP SCS
            Worksheets(3).Cells(y3, 34).Value = Worksheets(1).Cells(y1, 34).Value                   'AEC CSI Red. FCWP
            Worksheets(3).Cells(y3, 35).Value = Worksheets(1).Cells(y1, 35).Value                   'Lock Up Design Chg. Best Pract. FCWP AEC
            Worksheets(3).Cells(y3, 36).Value = Worksheets(1).Cells(y1, 36).Value                   'Lock Up Design Chg. Best Pract. FCWP BSC
            Worksheets(3).Cells(y3, 37).Value = Worksheets(1).Cells(y1, 37).Value                   'Chg. Best Pract. FCWP SCS
            Worksheets(3).Cells(y3, 38).Value = Worksheets(1).Cells(y1, 38).Value                   'Chg. Red. AEC
            Worksheets(3).Cells(y3, 39).Value = Worksheets(1).Cells(y1, 39).Value                   'Chg. Red. BSC
            Worksheets(3).Cells(y3, 40).Value = Worksheets(1).Cells(y1, 40).Value                   'Chg. Red. SCS
            Worksheets(3).Cells(y3, 41).Value = Worksheets(1).Cells(y1, 41).Value                   'Invert. FCWP 3977.
            Worksheets(3).Cells(y3, 42).Value = Worksheets(1).Cells(y1, 42).Value                   'Invert. UIC FCWP
            Worksheets(3).Cells(y3, 43).Value = Worksheets(1).Cells(y1, 43).Value                   'PCD FCWP
            Worksheets(3).Cells(y3, 44).Value = Worksheets(1).Cells(y1, 44).Value                   'WT FCWP
            
            If Worksheets(3).Cells(y3, 12) <> "Removed from CR" Then
                Worksheets(3).Cells(y3, 6).Interior.Color = RGB(255, 235, 156)
                Worksheets(3).Cells(y3, 6).Font.Color = RGB(156, 101, 0)
            End If

            y1 = y1 + 1
        End If

        y3 = y3 + 1
    Loop
    Loop
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  
    ''''''''''''''''''''''''''Formating''''''''''''''''''''''''''''''
    Columns("A:AR").HorizontalAlignment = xlCenter
    
    Do While i <= Worksheets(3).Range("F1", Worksheets(3).Range("F1").End(xlDown)).Rows.Count
        If Worksheets(3).Cells(i, 12) = "Removed from CR" Then
            Worksheets(3).Cells(i, 12).Interior.Color = RGB(255, 199, 206)
            Worksheets(3).Cells(i, 12).Font.Color = RGB(156, 0, 6)
            Worksheets(3).Cells(i, 18).Interior.Color = RGB(255, 199, 206)
            Worksheets(3).Cells(i, 18).Font.Color = RGB(156, 0, 6)
            
            Worksheets(3).Cells(i, 13).Font.Strikethrough = True
            Worksheets(3).Cells(i, 14).Font.Strikethrough = True
            Worksheets(3).Cells(i, 16).Font.Strikethrough = True
        End If
        If Worksheets(3).Cells(i, 12) = "Approved CN Stamped" Then
            Worksheets(3).Cells(i, 12).Interior.Color = RGB(198, 239, 206)
            Worksheets(3).Cells(i, 12).Font.Color = RGB(0, 97, 0)
        End If
        If Worksheets(3).Cells(i, 18) = "Drawing Released" Then
            Worksheets(3).Cells(i, 18).Interior.Color = RGB(198, 239, 206)
            Worksheets(3).Cells(i, 18).Font.Color = RGB(0, 97, 0)
        End If

        i = i + 1
    Loop
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

