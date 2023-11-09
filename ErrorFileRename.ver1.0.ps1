cls
#-----------------------------------[VARIABLES]---------------------------------------
$removeString = "temp_"
$findString = "*.xml"
$fromPath = "C:\Temp"
$toPath
$i = 0
$newName = @()
$oldName = @((Get-ChildItem -Path $fromPath | Where-Object Name -like $findString).Name)
#-----------------------------------[VARIABLES]---------------------------------------

#-----------------------------------[FUNCTIONS]---------------------------------------
function Get-FileOutputMessage{
    Param
    (
        [parameter(mandatory)][string] $outGoingFile,
        [parameter(mandatory)][string] $incomingFile 
    )
    write-host "$($outGoingFile)" -ForegroundColor DarkBlue -BackgroundColor DarkGray -NoNewline
    write-host " :: WAS ::" -NoNewline
    write-host " $($incomingFile)"

}

#-----------------------------------[FUNCTIONS]---------------------------------------


foreach($o in $oldName){
    $newName += $o.Replace($removeString,"") 
    $i++   
}

for($i = 0; $i -lt $oldName.Length; $i++){
    Rename-Item -Path "$($fromPath)\$($oldName[$i])" -NewName $newName[$i]

    Get-FileOutputMessage -outGoingFile $newName[$i] -incomingFile $oldName[$i]

   
}


<#---------------------------------------------------------------------------
# This code below just creates files in the path. Using just for testing pursposes

for($i = 0;$i -le 5;$i++){
    New-Item -Path $fromPath -Name "temp$($i)_file.xml"
}
----------------------------------------------------------------------------#> 
