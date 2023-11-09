cls
#-----------------------------------[VARIABLES]---------------------------------------
#$removeString = "temp_"
$removeString

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

function Get-InitialInput{
    Param
    (
        #[parameter(mandatory)][string] $removeThis
        #[parameter(mandatory)][]    
    )  
    
    write-host "Please enter string that you want to remove: " -NoNewline
    [string]$removeString = read-host
    write-host "Passing $($removeString)!"
    
    $returnedString = Check-InputValidation -checkThis $removeString
    #$testFun = test-fun
    print-this -input 'YOU KNOW WHAT!' 
    #$returnedString = $returnedString.trim()
    write-host "I've returned $returnedString for you!" -ForegroundColor DarkMagenta -BackgroundColor White
    #$returnedString
    write-host "What will you now do with$($returnedString)?"

}
function print-this([string] $input){
    Write-host "This is a test for "
    $input
}

function Check-InputValidation{
    Param(
        [string] $checkThis
    ) 
    $yesOrNo = "n"             
    do{
    write-host "Are you sure that " -nonewline
    write-host "`"$($checkThis)`"" -ForegroundColor red -BackgroundColor White -NoNewline
    write-host " is the name you want to remove? (Y/N): " -NoNewline
    $yesOrNo = Read-Host
    $yesOrNo = $yesOrNo[0].toString().ToLower()
    if($yesOrNo -eq 'y'){
        write-host "RETURNING $($checkThis)"
        return $checkThis
    }
    elseif($yesOrNo -eq 'n'){
        write-host "Please enter the correct string you'd like to remove : " -NoNewline
        $checkThis = Read-Host
    }
    else{
        write-host "Please enter valid selection" -Verbose
    }
    }while($yesOrNo = 'n')
}

#-----------------------------------[FUNCTIONS]---------------------------------------

<#
write-host "Please enter something: " -nonewline
$removeString = read-host
write-host $removeString
#>

Get-InitialInput

<#

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
