#Parameters
$SiteURL = "https://orielstat.sharepoint.com"
$ReportOutput = "C:\Temp\SitePermissionRpt.csv"

get-sposite -identity "https://orielstat.sharepoint.com/sites/abbottdiabetescare" | format-list

get-spositegroup
add-spo

add-spouser -Site "https://orielstat.sharepoint.com/sites/abio-1427-axsess-mdr" -Group "ABIO-1427-AXSESS-MDR Owners" -loginname jhuson@orielstat.com

##CODE TO ADD USER AS SITE ADMIN FOR SHAREPOINT
$Site1 = Get-SPOSite -limit all
$site1.url | ForEach-Object { 

                                write-host $_ -BackgroundColor DarkBlue -ForegroundColor yellow
                                Set-SPOUser -Site $_ -LoginName jhuson@orielstat.com -IsSiteCollectionAdmin $true      
                                

                            }# | out-file -filepath "c:\temp\outfile.txt" -Append

Set-SPOUser -Site "https://orielstat.sharepoint.com/sites/consultantgrouptemplate" -LoginName jhuson@orielstat.com -IsSiteCollectionAdmin $true



#Connect to Site
Connect-PnPonline -Url $SiteURL


#Get the web
$Web = Get-PnPWeb -Includes RoleAssignments
 
#Loop through each permission assigned and extract details
$PermissionData = @()
ForEach ($RoleAssignment in $Web.RoleAssignments)
{
    #Get the Permission Levels assigned and Member
    Get-PnPProperty -ClientObject $RoleAssignment -Property RoleDefinitionBindings, Member
     
    #Get the Permission Levels assigned
    $PermissionLevels = ($RoleAssignment.RoleDefinitionBindings | Select -ExpandProperty Name | Where {$_ -ne "Limited Access"}) -join ","
    $PermissionType = $RoleAssignment.Member.PrincipalType
 
    #Leave Principals with no Permissions
    If($PermissionLevels.Length -eq 0) {Continue}
     
    #Collect Permission Data
    $Permissions = New-Object PSObject
    $Permissions | Add-Member NoteProperty Name($RoleAssignment.Member.Title)
    $Permissions | Add-Member NoteProperty Type($PermissionType)
    $Permissions | Add-Member NoteProperty PermissionLevels($PermissionLevels)
    $PermissionData += $Permissions
}
 
$PermissionData
$PermissionData | Export-csv -path $ReportOutput -NoTypeInformation


#Read more: https://www.sharepointdiary.com/2020/08/sharepoint-online-get-subsite-permission-using-powershell.html#ixzz7L5O9lU8H