[string] $testStr = "c:\temp\tempFolderDELETETHIS"
[string] $testStrVar =  "c:\temp\tempFolderDELETETHIS\this\is\just\a\test\for\things.txt"
[int] $indexNum = $testStrVar.LastIndexOf('\')
[string] $subString1 = $testStrVar.Substring(0, $indexNum)
[string] $oneUpPath = $subString1.SubString(0, $subString1.LastIndexOf('\'))
$twoUpPath = $oneUpPath.Substring(0, $oneUpPath.LastIndexOf('\'))
$threeUpPath = $twoUpPath.Substring(0, $twoUpPath.LastIndexOf('\'))

$splitter = $testStrVar.Split('\')






#Below is where the names of the folders are initialized as a variable. Check the second variable. Thats where you change the name at.
<#
$WordA = $subString1.Substring($subString1.LastIndexOf('\') + 1, $subString1.Length - $subString1.LastIndexOf('\') - 1)
$WordB = $oneUpPath.Substring($oneUpPath.LastIndexOf('\') + 1, $oneUpPath.Length - $oneUpPath.LastIndexOf('\') - 1)
$WordC = $twoUpPath.Substring($twoUpPath.LastIndexOf('\') + 1, $twoUpPath.Length - $twoUpPath.LastIndexOf('\') - 1)
#>

$renameWordA = "A"
$renameWordB = "B"
$renameWordC = "C"
$destinationPath = "z:\temp_Transfering_Files"


Rename-Item -Path $subString1 -NewName $renameWordA # Renames the folder
Rename-Item -Path $oneUpPath -NewName $renameWordB
Rename-Item -Path $twoUpPath -NewName $renameWordC




$newPath = "$($threeUpPath)\$($renameWordC)\$($renameWordB)\$($renameWordA)"


# FIX ME: File Transfer
robocopy $threeUpPath $destinationPath 


Rename-Item -Path "$($oneUpPath)\$($renameWord)" -NewName $originalWord #Renames the folder back to the original name



$stringWords = @("this", "is", "just", "a", "test", "for")
$filepath = $testStr
foreach($o in $stringWords){
    New-Item -Path $filepath -Name $o -type directory
    $filepath = "$($filepath)\$o"
    write-host "New Filepath = $($filepath)"
}


J:\Leads-New\LEADS\2023 S LEADS