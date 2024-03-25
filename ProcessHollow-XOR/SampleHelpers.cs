using System;
using System.Runtime.InteropServices;
using static Process_Hollowing.Imports.Imports;

internal static class SampleHelpers
{
    [DllImport("ntdll.dll")]
    public static extern int ZwQueryInformationProcess(IntPtr hProcess, int procInformationClass, ref PROCESS_BASIC_INFORMATION procInformation, uint ProcInfoLen, ref uint retlen);
}