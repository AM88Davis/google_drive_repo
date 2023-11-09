cls

$newFileName = "BP-TEST-File2.csv"
$newFilePath = "C:\Users\Anthony.Davis\OneDrive - Carden I.T Services Limited\Desktop\Test\"
if($newFilePath[-1] -eq '\'){
    $newFilePath = $newFilePath.Substring(0,$newFilePath.Length-1)
} 
$newFileNamePath = "$($newFilePath)\$($newFileName)"
$fileNames = @()
$test = @()
$textFile = Get-Content "C:\Users\Anthony.Davis\OneDrive - Carden I.T Services Limited\Desktop\Test\BP-Error-file-logs.txt"
$textFile = $textFile -replace (" :: WAS :: ", " ") -replace (" ", ",")
$fileNames += $textFile.split(",")


foreach($f in $fileNames){
    $test += [PSCustomObject]@{FileName = $f}
}

$test | Export-Csv -Path $newFileNamePath -NoTypeInformation