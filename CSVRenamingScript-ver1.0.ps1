cls
$date1 = get-date -format MMddyyyyhhmmss
$addName = Read-Host "What would you like the prefix to be?"
$start_file = import-csv -path "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\TARGETCSVFILE1.csv"

for($i=0;$i -lt $start_file.Length;$i++)
{
    $start_file[$i].name = $addName + $start_file[$i].name
    $start_file[$i]
}

$start_file | export-csv -path ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\" +$addName+"OUTCSV_"+$date1+".csv")


