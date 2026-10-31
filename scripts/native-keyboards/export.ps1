param([string]$Id='00000407',[string]$OutFile=(Join-Path (Get-Location) 'work\native-keyboards\base.klc'))
$ErrorActionPreference='Stop'
$OutFile=$ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutFile)
$previousDirectory=[Environment]::CurrentDirectory
Add-Type -AssemblyName System.Windows.Forms
$a=[Reflection.Assembly]::LoadFile('C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4\MSKLC.exe')
$flags=[Reflection.BindingFlags]'Public,NonPublic,Instance,Static'
$t=$a.GetType('Microsoft.Globalization.Tools.KeyboardLayoutCreator.Keyboard')
$ctor=$t.GetConstructors($flags)[0]
function Field($name) { return ,$t.GetField($name,$flags).GetValue($keyboard) }
Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class LayoutExport {
 [DllImport("user32.dll",CharSet=CharSet.Unicode)] public static extern IntPtr LoadKeyboardLayout(string id,uint flags);
 [DllImport("user32.dll")] public static extern bool UnloadKeyboardLayout(IntPtr hkl);
 [DllImport("user32.dll")] public static extern int GetKeyboardLayoutList(int count,[Out] IntPtr[] list);
 public static IntPtr[] Loaded() {
   var list=new IntPtr[GetKeyboardLayoutList(0,null)];
   GetKeyboardLayoutList(list.Length,list);return list;
 }
}
'@
$loadedBefore=@([LayoutExport]::Loaded())
$keyboard=$null
try {
$keyboard=$ctor.Invoke([object[]]@([string[]]@(),$true))
# InitVirtualKeys loads the source itself. Preloading it here made MSKLC
# treat it as pre-existing and leave it in the user's keyboard switcher.
$layoutId=[UIntPtr][Convert]::ToUInt32($Id,16)
$t.GetMethod('InitVirtualKeys',$flags).Invoke($keyboard,[object[]]@($layoutId,$true)) | Out-Null
$t.GetMethod('AssignScancodes',$flags).Invoke($keyboard,@()) | Out-Null
$tf=$a.GetType('Microsoft.Globalization.Tools.KeyboardLayoutCreator.KeyboardTextFile')
$exportCtor=$tf.GetConstructors($flags) | Where-Object { $_.GetParameters().Count -gt 1 }
$ci=[Globalization.CultureInfo]::GetCultureInfo([Convert]::ToInt32($Id.Substring(4),16))
$params=[object[]]@($OutFile,'TestKbd','Test keyboard',$ci,'Javier','(c) 2026 Javier',$layoutId,(Field 'm_vks'),(Field 'm_alNames'),(Field 'm_alExtNames'),(Field 'm_alAttributes'),(Field 'm_alDescriptions'),(Field 'm_alLanguageNames'))
$exportCtor.Invoke($params) | Out-Null
Write-Output $OutFile
} finally {
    if($null -ne $keyboard){$keyboard.Dispose()}
    [Environment]::CurrentDirectory=$previousDirectory
    foreach($handle in [LayoutExport]::Loaded()) {
        if($handle -notin $loadedBefore){
            if(-not [LayoutExport]::UnloadKeyboardLayout($handle)){
                Write-Warning ('Windows retained a temporary layout: '+$handle.ToInt64().ToString('X8'))
            }
        }
    }
}
