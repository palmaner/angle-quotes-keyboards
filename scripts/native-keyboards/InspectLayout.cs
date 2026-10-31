using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public sealed class LayoutTables : IDisposable {
    [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)] static extern IntPtr LoadLibrary(string path);
    [DllImport("kernel32.dll")] static extern IntPtr GetProcAddress(IntPtr module,string name);
    [DllImport("kernel32.dll")] static extern bool FreeLibrary(IntPtr module);
    [UnmanagedFunctionPointer(CallingConvention.Winapi)] delegate IntPtr Descriptor();
    IntPtr module, tables, modifiers, chars, scans;
    int ptrSize;
    public LayoutTables(string path) : this(path,false) {}
    public LayoutTables(string path,bool longPointers) {
        ptrSize=longPointers ? 8 : IntPtr.Size;
        module=LoadLibrary(path);
        if(module==IntPtr.Zero) throw new Exception("Cannot load "+path+": "+Marshal.GetLastWin32Error());
        var proc=GetProcAddress(module,"KbdLayerDescriptor");
        if(proc==IntPtr.Zero) throw new Exception("No KbdLayerDescriptor");
        tables=((Descriptor)Marshal.GetDelegateForFunctionPointer(proc,typeof(Descriptor)))();
        modifiers=Marshal.ReadIntPtr(tables,0);
        chars=Marshal.ReadIntPtr(tables,ptrSize);
        scans=Marshal.ReadIntPtr(tables,6*ptrSize);
    }
    public int VirtualKey(int scan) { return ((ushort)Marshal.ReadInt16(scans,scan*2))&255; }
    public string Symbol(int vk,int mod,bool caps) {
        int max=(ushort)Marshal.ReadInt16(modifiers,ptrSize);
        int column=mod<=max ? Marshal.ReadByte(modifiers,ptrSize+2+mod) : 15;
        for(int t=0;t<30;t++) {
            IntPtr table=IntPtr.Add(chars,t*(ptrSize==8?16:8));
            IntPtr rows=Marshal.ReadIntPtr(table);
            if(rows==IntPtr.Zero) break;
            int n=Marshal.ReadByte(table,ptrSize), size=Marshal.ReadByte(table,ptrSize+1);
            for(int r=0;r<300;r++) {
                IntPtr row=IntPtr.Add(rows,r*size);
                int key=Marshal.ReadByte(row);
                if(key==0) break;
                if(key!=vk) continue;
                int attr=Marshal.ReadByte(row,1), selected=column;
                if(caps && (((attr&1)!=0 && mod<=1) || ((attr&4)!=0 && mod>=6))) {
                    int cm=mod^1;
                    selected=cm<=max ? Marshal.ReadByte(modifiers,ptrSize+2+cm) : 15;
                }
                if(caps && (attr&2)!=0 && mod<=1) row=IntPtr.Add(row,size);
                if(selected>=n) continue;
                int value=(ushort)Marshal.ReadInt16(row,2+selected*2);
                if(value==0xf000) return "";
                if(value==0xf001) {
                    int accent=(ushort)Marshal.ReadInt16(IntPtr.Add(row,size),2+selected*2);
                    return "dead:"+accent.ToString("x4");
                }
                return value.ToString("x4");
            }
        }
        return "";
    }
    public Dictionary<string,string> DeadKeys() {
        var result=new Dictionary<string,string>();
        IntPtr p=Marshal.ReadIntPtr(tables,2*ptrSize);
        if(p==IntPtr.Zero) return result;
        for(int i=0;i<10000;i++) {
            IntPtr row=IntPtr.Add(p,i*8);
            uint both=(uint)Marshal.ReadInt32(row);
            if(both==0) break;
            result[both.ToString("x8")]=((ushort)Marshal.ReadInt16(row,4)).ToString("x4")+":"+((ushort)Marshal.ReadInt16(row,6));
        }
        return result;
    }
    public void Dispose() { if(module!=IntPtr.Zero){FreeLibrary(module);module=IntPtr.Zero;} }
}
