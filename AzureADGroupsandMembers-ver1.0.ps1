Connect-AzureAD
$temp_group_member = @()
$temp_groups= @()
$temp_users = @()
$temp_group_membership = @()
$temp_object = @()
$temp_array = @()
$date01 = Get-Date -Format yyyyMMdd-hhmm
$output_file = "c:\temp\GroupMembership$($date01).csv"


foreach ($i in Get-AzureADUser -all $true | sort -property displayname){
    $temp_users += $i
}

foreach ($i in (Get-AzureADGroup -all $true | sort -Property displayname)){
    $temp_array1 = @()
    write-host -nonewline "Now Printing group membership of: "
    write-host $i.DisplayName -ForegroundColor Black -b Cyan

    $temp_array1 += Get-AzureADGroupMember -ObjectId $i.ObjectId
    $temp_array1.displayname | sort
    (Get-AzureADGroupMember -ObjectId $i.ObjectId).length
    write-host
 
    if(($temp_array1.displayname).count -le 1){
         $temp_object = [PSCustomObject] @{"GroupName" = $i.DisplayName; "Users" = $temp_array1.displayname}
         $temp_object | Export-Csv -Path $output_file -NoTypeInformation -append
    }
    else{
        foreach($j in $temp_array1.displayname){
            $temp_object = [pscustomobject] @{"GroupName" = $i.displayname; "Users" = $j}
            $temp_object | Export-Csv -Path $output_file -NoTypeInformation -append
        }
    }
    
}
