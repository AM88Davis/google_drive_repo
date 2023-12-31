﻿[void][System.Reflection.Assembly]::LoadWithPartialName
("Microsoft.SharePoint")
$SPSiteUrl = "https://orielstat-admin.sharepoint.com"
$SPSite = $SPSiteUrl
$ExportFile = "C:\temp\Permissions.csv" 
"Web Title,Web URL,List Title,User or Group,Role,Inherited" | out-file $ExportFile 
foreach ($WebPath in $SPSite.AllWebs)
{
   if ($WebPath.HasUniqueRoleAssignments)
        {
          $SPRoles = $WebPath.RoleAssignments;
          foreach ($SPRole in $SPRoles)
          {
            foreach ($SPRoleDefinition in $SPRole.RoleDefinitionBindings)
            {
                $WebPath.Title + "," + $WebPath.Url + "," + "N/A" + "," +
$SPRole.Member.Name + "," + $SPRoleDefinition.Name + "," +
$WebPath.HasUniqueRoleAssignments | out-file $ExportFile -append
            }
          }
        }           
        foreach ($List in $WebPath.Lists)
        {
           if ($List.HasUniqueRoleAssignments)
           {
             $SPRoles = $List.RoleAssignments;
             foreach ($SPRole in $SPRoles)
             {
               foreach ($SPRoleDefinition in $SPRole.RoleDefinitionBindings)
               {
                    $WebPath.Title + "," + $WebPath.Url + "," + $List.Title + "," +
$SPRole.Member.Name + "," + $SPRoleDefinition.Name | out-file $ExportFile -append
               }
             }
           }
        }
}
$SPSite.Dispose();