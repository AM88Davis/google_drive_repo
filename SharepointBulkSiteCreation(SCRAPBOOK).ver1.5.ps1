<#
$username = "jhuson@validant.com"
$password = "x9%MJRMYzugB"
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)
Connect-SPOService -Url https://validanto365-admin.sharepoint.com -Credential $cred
#>

 $sharepointSite = "https:\\8cbqf0-admin.sharepoint.com"
 $adminSPO = "adavis@8cbqf0.onmicrosoft.com"

Connect-SPOService -Url $sharepointSite #-Credential $adminSPO
$tempcsv = import-csv ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\testcsv1.csv")
$newCSV = $tempcsv | Select-Object @{Name='New URL'; Expression={($_.url)}},@{Name='BLURL...AGAIN!?'; Expression={($_.name)}}
$newCSV

Import-Csv ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\OsamRenamedSites(temp1).csv") | Foreach-Object
 {
     #New-SPOSite -Title $_.newname -URL $_.SiteURL -Owner $_.SiteOwner -StorageQuota $_.StorageQuota -Template $_.SiteTemplate
     #write-host $_.newname 
 }
 $sharepointSite = "https:\\8cbqf0-admin.sharepoint.com"

 $importingSite = Import-Csv ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\MyTestSharepointSandbox.csv")

 for($i=0;$i -lt $importingsite.Length;$i++)
 {
    write-host "Now importing Site Name: " $importingSite[$i].NewName -ForegroundColor green
    New-SPOSite -Title $importingsite[$i].newname -url $importingsite[$i].siteurl -Owner $importingsite[$i].siteowner -StorageQuota $importingsite[$i].storagequota -Template $importingsite[$i].sitetemplate
    write-host "Now creating the Microsoft 365 Group:" $importingSite[$i].groupname -foregroundcolor blue
    Set-SPOSiteOffice365Group -Site $importingSite[$i].siteurl -DisplayName $importingSite[$i].groupName -alias $importingSite[$i].groupname
 
 }



 ######################################
 ##TEAMS SCRAPBOOK!
 #######################################
 connect-microsoftteams
 New-Team -DisplayName "Team Test 2" -Description "Team to post technical articles and blogs 2" -Visibility Public
 set-SPOUnifiedGroup -GroupAlias "TestGroup5" -PreferredDataLocation "https://8cbqf0.sharepoint.com/sites/TEST5"

 $teamDisplayName = get-team | Select-Object -property Displayname
 $teamDisplayName[0].DisplayName

 for ($i=0;$i -lt $teamDisplayName.Length;$i++)
 {
    if ($teamDisplayName[$i].displayname -eq "Test 3")
    {
        Write-Host "YESSS, WE WON" -f Cyan
    }
    else
    {
        Write-Host "NO, WE LOST!" -f DarkGray -b DarkMagenta
    }
 }
 
 

 $importingSite[0].groupName + "Group"

 ######
 Set-SPOSiteOffice365Group -Site https://8cbqf0.sharepoint.com/sites/TEST10DELETESPACESNOW -DisplayName "Test10Group" -Alias "test10group"
 ######

 Set-SPOSiteOffice365Group -Site "https://8cbqf0.sharepoint.com/sites/TEST1%20DELETE%20SPACES%20NOW" -DisplayName "Test Group1" -Alias "Test Group 1" -IsPublic
 #Set-SPOSiteOffice365Group -site "https://8cbqf0.sharepoint.com/sites/TEST2%20DELETE%20SPACES%20NOW" -

 #Set-SPOSiteGroup -Site "https://8cbqf0.sharepoint.com/sites/TEST2%20DELETE%20SPACES%20NOW" -
 Set-SPOSiteGroup -Site "https://8cbqf0.sharepoint.com/sites/TEST1%20DELETE%20SPACES%20NOW" -Site https://contoso.sharepoint.com/sites/siteA -Identity "TESTGROUP3" -PermissionLevelsToRemove "Full Control" -PermissionLevelsToAdd "View Only" -Identity "ProjectViewers" -PermissionLevelsToRemove "Full Control" -PermissionLevelsToAdd "Full Control" -owner $adminSPO
 New-SPOSiteGroup -Site "https://8cbqf0.sharepoint.com/sites/TEST1%20DELETE%20SPACES%20NOW" -title "Granted" -PermissionLevels "Full Control  


 get-sposite -Identity "https://validanto365.sharepoint.com/sites/testingweqe" -Detailed|fl

 $importingsite
 
 Set-SPOUser -Identity "ashah@validanto365.onmicrosoft.com" -Web $sharepointSite + "/" #-Group "Marketing Owners"
 Add-SPOUser -Site https://validanto365.sharepoint.com/sites/OSAM-1-%20Consultant%20Group%20Template -LoginName "ashah@validanto365.onmicrosoft.com"  -Group "OSAM-1- Consultant Group Template Members"


$temp2 = import-csv ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\TARGETCSVFILE1.csv")
$renamed1 = $temp2 | Select-Object @{Name='NewName'; Expression={($_.Name)}},@{name='SiteURL';expression={''}}, @{Name='StorageQuota'; expression={'500'}},@{name='SiteOwner';Expression={'JHuson@Validant.com'}},@{name='SiteTemplate';expression={'STS#3'}}
$renamed1
for($i=0;$i -lt $renamed1.Length;$i++)
{
    $renamed1[$i].newname = "OSAM-" + $renamed1[$i].newname
    $renamed1[$i].SiteURL = "https://validanto365.sharepoint.com/sites/" + $renamed1[$i].newname
    #$renamed1[$i].StorageQuota = "500"
    $renamed1[$i].newname
}
$renamed1.siteurl


$renamed1 |export-csv ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\OsamRenamedSites(2).csv") -NoTypeInformation