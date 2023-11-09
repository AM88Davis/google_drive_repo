cls
$date1 = Get-Date -format MMddyyyyhhmm
$name1 = "Hello"
$csvfile1 = import-csv "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\TARGETCSVFILE.csv"
$csvfile1.'﻿"Site name"'
$obj_file = $csvfile1.'﻿"Site name"' | Select-Object @{Name='Name';Expression={($_)}}  
$obj_file | export-csv -path ("G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\TESTOUTPUT" + $date1 + '.csv') -NoTypeInformation

Import-Module activedirectory