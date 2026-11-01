# Windows Installer inventory and operation planning. Loading this file changes nothing.
function Initialize-AqMsiInventory {
    if('AqMsiInventory' -as [type]){return}
    Add-Type @'
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Text;
public sealed class AqMsiProduct {
    public string ProductCode, UserSid, Name, LocalPackage;
    public int Context;
}
public static class AqMsiInventory {
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    static extern uint MsiEnumProductsEx(string product, string sid, uint contexts, uint index,
        StringBuilder code, out uint context, StringBuilder owner, ref uint ownerLength);
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    static extern uint MsiGetProductInfoEx(string product, string sid, uint context,
        string property, StringBuilder value, ref uint length);
    static string Property(string code, string sid, uint context, string property) {
        uint size=0;
        uint result=MsiGetProductInfoEx(code, context==4?null:sid, context, property, null, ref size);
        if(result==1605) return "";
        if(result!=0 && result!=234) throw new Win32Exception((int)result, "MSI inventory: "+property);
        var value=new StringBuilder((int)size+1); size++;
        result=MsiGetProductInfoEx(code, context==4?null:sid, context, property, value, ref size);
        if(result!=0) throw new Win32Exception((int)result, "MSI inventory: "+property);
        return value.ToString();
    }
    public static AqMsiProduct[] Read() {
        var products=new List<AqMsiProduct>();
        // NULL SID: current-user contexts and machine context only. No foreign-user removal.
        for(uint index=0;;index++) {
            var code=new StringBuilder(39); var sid=new StringBuilder(256);
            uint context, length=256;
            uint result=MsiEnumProductsEx(null,null,7,index,code,out context,sid,ref length);
            if(result==259) break;
            if(result!=0) throw new Win32Exception((int)result, "MSI product enumeration");
            string id=code.ToString(), owner=sid.ToString();
            if(Property(id,owner,context,"State")!="5") continue;
            products.Add(new AqMsiProduct {ProductCode=id, UserSid=owner, Context=(int)context,
                Name=Property(id,owner,context,"ProductName"),
                LocalPackage=Property(id,owner,context,"LocalPackage")});
        }
        return products.ToArray();
    }
}
'@
}
function Get-AqMsiProducts {
    Initialize-AqMsiInventory
    @([AqMsiInventory]::Read())
}
function Get-AqMsiPackage([string]$Path) {
    $installer=$null;$db=$null;$view=$null
    try {
        $installer=New-Object -ComObject WindowsInstaller.Installer
        $db=$installer.OpenDatabase([IO.Path]::GetFullPath($Path),0)
        $view=$db.OpenView('SELECT `Property`,`Value` FROM `Property`')
        [void]$view.Execute();$properties=@{}
        while($record=$view.Fetch()){
            try{$properties[$record.StringData(1)]=$record.StringData(2)}
            finally{[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($record)}
        }
        [pscustomobject]@{ProductCode=$properties.ProductCode;Name=$properties.ProductName;LayoutFile=$properties.LayoutFile}
    }finally{
        if($view){[void]$view.Close();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($view)}
        if($db){[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($db)}
        if($installer){[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($installer)}
    }
}
function Get-AqMsiUserSid {[Security.Principal.WindowsIdentity]::GetCurrent().User.Value}
function Select-AqInstalledMsi($Layout,$Products) {
    $currentSid=Get-AqMsiUserSid
    $verified=@(foreach($product in $Products){
        if($product.Context -notin @(1,2,4)){continue}
        if($product.Context -ne 4 -and $product.UserSid -ne $currentSid){continue}
        if($product.Name -ne $Layout.title){continue}
        if(-not $product.LocalPackage -or -not (Test-Path -LiteralPath $product.LocalPackage -PathType Leaf)){continue}
        $cached=Get-AqMsiPackage $product.LocalPackage
        if($cached.ProductCode -ne $product.ProductCode -or $cached.LayoutFile -ne ($Layout.name+'.dll') -or $cached.Name -ne $Layout.title){continue}
        if($product.ProductCode -notmatch '^\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}$'){continue}
        $product
    })
    if($verified.Count -eq 1){return [pscustomobject]@{Available=$true;Reason='';Product=$verified[0]}}
    $reason=if($verified.Count -gt 1){'uninstallAmbiguous'}else{'uninstallUnknown'}
    [pscustomobject]@{Available=$false;Reason=$reason;Product=$null}
}
function Get-AqMsiPlan($Layout,[string]$PackageRoot,[switch]$Uninstall) {
    $suffix=if([Environment]::Is64BitOperatingSystem){'_amd64.msi'}else{'_i386.msi'}
    $msi=Join-Path $PackageRoot ($Layout.name+$suffix)
    if(-not (Test-Path -LiteralPath $msi -PathType Leaf)){throw ('Missing MSI: '+$msi)}
    $package=Get-AqMsiPackage $msi
    if($package.LayoutFile -ne ($Layout.name+'.dll') -or $package.Name -ne $Layout.title){throw 'MSI does not match the selected keyboard.'}
    if($Uninstall){
        $products=@(Get-AqMsiProducts)
        $selection=Select-AqInstalledMsi $Layout $products
        if(-not $selection.Available){
            return [pscustomobject]@{Available=$false;Reason=$selection.Reason;RequestedCode=$package.ProductCode;CurrentUserSid=(Get-AqMsiUserSid);Candidates=@($products | Where-Object Name -eq $Layout.title)}
        }
        $product=$selection.Product
        return [pscustomobject]@{Available=$true;Operation='uninstall';Target=$product.ProductCode;Context=$product.Context;OwnerSid=$product.UserSid;Elevate=($product.Context -eq 4);PackageCode=$package.ProductCode}
    }
    # Layout DLLs live in the system directory. New registrations must be per-machine,
    # rather than registered under an administrator whose credentials were supplied.
    [pscustomobject]@{Available=$true;Operation='install';Target=$msi;Context=4;OwnerSid='';Elevate=$true;PackageCode=$package.ProductCode}
}
function Get-AqMsiArguments($Plan,[string]$LogPath) {
    if(-not $Plan.Available){throw 'No verified MSI operation available.'}
    if($Plan.Operation -eq 'uninstall'){
        if($Plan.Target -notmatch '^\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}$'){throw 'Invalid installed product code.'}
        $arguments='/x '+$Plan.Target
    }elseif($Plan.Operation -eq 'install'){$arguments='/i "'+$Plan.Target+'"'}
    else{throw 'Invalid MSI operation.'}
    if($Plan.Context -eq 4){$arguments+=' ALLUSERS=1'}
    $arguments+' /passive /norestart /L*V "'+$LogPath+'"'
}
function Test-AqMsiCompletion($Plan) {
    $products=@(Get-AqMsiProducts)
    if($Plan.Operation -eq 'uninstall'){
        return (@($products | Where-Object {$_.ProductCode -eq $Plan.Target -and $_.Context -eq $Plan.Context}).Count -eq 0)
    }
    return (@($products | Where-Object {$_.ProductCode -eq $Plan.PackageCode -and $_.Context -eq 4}).Count -eq 1)
}
