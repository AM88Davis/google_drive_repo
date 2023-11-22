cls
$date1 = get-date -format MMddyyyyhhmmss
$addName = Read-Host "What would you like the prefix to be?"
$start_file = import-csv -path "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\TARGETCSVFILE1.csv"

# A "for loop" that declares the $i variable in the for loop declaration, and runs for the entire length
# of the $start_file array. Increments by one at the end of each iteration of the loop. This basically
# a "foreach" loop
<#
for($i=0;$i -lt $start_file.Length;$i++)
{
    $start_file[$i].name = $addName + $start_file[$i].name
    $start_file[$i]
}
#>

# A "foreach loop" that does that same as above, just in a different syntax.
foreach ( $o in $start_file){

    $o.Name = $addName + $o.Name
    $o
}


$start_file | export-csv -path ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\" +$addName+"OUTCSV_"+$date1+".csv")


