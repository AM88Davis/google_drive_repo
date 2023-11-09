#SPO-specific cmdlets require sharepoint-online module

Install-Module -Name Microsoft.Online.SharePoint.PowerShell

$ServiceURL ="https://orielstat-admin.sharepoint.com"

$URL = "https://orielstat-admin.sharepoint.com"

$Path = "C:\Temp\GroupsReport.csv"

#$Cred =  Get-Credential

#Connect to SharePoint Online
 
Connect-SPOService -url $ServiceURL

#Generating Report

$GroupsData = @()

#get sharepoint online groups powershell

Get-SPOSiteGroup -site "https://orielstat.sharepoint.com/sites/abca-1207-base-ivdr"

$SiteGroups = Get-SPOSiteGroup -Site $URL

ForEach($Group in $SiteGroups) {

    $GroupsData +=New-Object PSObject-Property @{

        'Group Name' =$Group.Title

        'Permissions' =$Group.Roles -join ","

        'Users' =  $Group.Users -join ","

    }

}

#Export the data to CSV
$GroupsData

$GroupsData |Export-Csv $Path -NoTypeInformation