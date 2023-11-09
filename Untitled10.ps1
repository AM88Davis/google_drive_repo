#Import SharePoint.Online.Management.Shell
Import-Module Microsoft.Online.Sharepoint.PowerShell

#Config Parameters
$AdminSiteURL="https://orielstat-admin.sharepoint.com"
$ReportOutput ="C:\Temp\ExternalUsersRpt10.csv"

#Get Credentials to connect
$Cred = Get-Credential
Connect-SPOService -url "https://orielstat-admin.sharepoint.com"

#Connect to SharePoint Online Tenant Admin
Connect-SPOService -URL $AdminSiteURL -Credential $Cred

#Get all Site Collections
$SitesCollection = Get-SPOSite -Limit ALL

$ExternalUsers=@()
#Iterate through each site collection
ForEach($Site in $SitesCollection)
{
Write-host -f Yellow "Checking Site Collection:"$Site.URL

#Get All External users of the site collection
$ExtUsers = Get-SPOUser -Limit All -Site $Site.URL | Where {$_.LoginName -like "*#ext#*" -or $_.LoginName -like "*urn:spo:guest*"}
If($ExtUsers.count -gt 0)
{ 
#write-host -f red "FOUND SOMETHING IN $($site.url)"
Write-host -f Green "Found $($ExtUsers.count) External User(s)!"
#$ExtUsers | Select-Object *, @{name='Site URL';expression={($site.url)}}
$ExternalUsers += $ExtUsers | Select-Object *, @{name='Site URL';expression={($site.url)}}
#$ExternalUsers | Select-Object *, @{name='Site URL';expression={""}}
}
}


$ExternalUsers | Export-Csv -Path $ReportOutput -NoTypeInformation

$ExternalUsers[4] | format-list