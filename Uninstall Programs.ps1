cls
$testUninstall = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | Get-ItemProperty | Select-Object -Property Displayname,uninstallstring | sort -Property Displayname
#Get-Process | Select-Object ProcessName,id | 

<#
foreach($unin in $testUninstall){
    if ($unin.DisplayName -like "7*"){
        #Write-host "Hello $($unin.displayname)"
        write-host $unin.uninstallstring
        #& "C:\Windows\SYSTEM32\cmd.exe" "$unin.uninstallString /quiet /norestart"
        #& "cmd.exe" \c "$unin.uninstallString /quiet /norestart"
        #Start-Process $($unin.UninstallString) /quiet -Wait
        $unin | Uninstall-Package -WhatIf
    }
    
}
#>

Get-package -name * | sort name | ft name
$App = Read-Host -Prompt "Which Software from the listing would you like to uninstall ?"
Invoke-Command -ScriptBlock {
  Get-Package | where { $_.name -like '*App*' } | Uninstall-Package -WhatIf
}


## TO DO: Figure out a way to uninstall remotely, and quietly 7/14
