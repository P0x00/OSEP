## Process Hollowing
This is a poc for process hollowing shellcode technique wwritten in C# and made by [crypt0ace](https://crypt0ace.github.io). My edits consist only in a passphrase rather than a single char XOR routine.

### Powershell
It also contains a powershell script `hollow.ps1` which can load the program in it if you wanna do it all in memory without touching disk. Remember to change the IP.

### Bypass
Also includes a AMSI bypass which is loaded in the `hollow.ps1` script. The bypass is courtesy of [CRTP by pentester academy](https://www.pentesteracademy.com/activedirectorylab).

### Obfuscated Version
The obfuscated version is obfuscated with [Rosfuscator](https://github.com/Flangvik/RosFuscator) by [Melvin Langvik](https://twitter.com/flangvik).
