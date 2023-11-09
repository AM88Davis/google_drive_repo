$sharepointSite = "https:\\validanto365-admin.sharepoint.com"
Connect-SPOService -Url $sharepointSite #-Credential $adminSPO


 $importingSite = Import-Csv ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\ValidantSharepointandGroupCreation.csv")
 $updateToGroupname = $importingSite | Select-Object *, @{name='GroupName';expression={$null}}
 
 
 <#
 $importingSite | ForEach-Object{
                                    $createGroupName += $_.newname + " Group"
                                    
                                }
                                $importingsite
 #>

 for ($i=0;$i -le $updatetogroupname.length;$i++)
 {
    Write-Host "Now udpating Group Name for $($updateToGroupname[$i].newname)"
    $updatetogroupname[$i].groupname = "OSAM-" + $updateToGroupname[$i].newname + " Group"
 }


 for($i=0;$i -le $updatetogroupname.count;$i++)
 {
    write-host "Now importing Site Name: " $importingSite[$i].NewName -ForegroundColor green
    New-SPOSite -Title $importingsite[$i].newname -url $importingsite[$i].siteurl -Owner $importingsite[$i].siteowner -StorageQuota $importingsite[$i].storagequota -Template $importingsite[$i].sitetemplate
    write-host "Now creating the Microsoft 365 Group:" $updatetogroupname[$i].groupname -foregroundcolor blue
    Set-SPOSiteOffice365Group -Site $importingSite[$i].siteurl -DisplayName $updateToGroupName[$i].groupName -alias $updatetogroupname[$i].groupname -mailNickname 
 
 }

 Get-SPOSiteGroup


 $i = 2
 $importingsite[2]

 Set-SPOSiteOffice365Group -Site $importingSite[$i].siteurl -DisplayName "OSAM-Abbott Diabetes Care" -alias "OSAM-AbbottDiabetesCare"

 $updateToGroupname | export-csv -path "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\ValidantSharepointandGroupCreation2.csv" -NoTypeInformation

Get-Unifiedgroup -filter *
New-UnifiedGroup -DisplayName "TEST Department" -Alias "engineering"

New-AzureADMSGroup -DisplayName "Test Group 2" -Description "Group assignable to role" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
Connect-AzureAD

$importingSite[$i]
"OSAM-" + $updateToGroupname[$i].newname