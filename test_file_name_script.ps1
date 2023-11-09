cls
function Set-AppendFunction{
    Param
    (
        $tempList,
        $tempPath, 
        $iteration
    )
    foreach($f in $tempPath){
        try{
            New-Item "$($tempPath)\$($f)TEST$($i)"
            throw
        }
        catch{
            $i++
            Set-AppendFunction -tempList $tempList -tempPath $tempPath -iteration $i
        }
    }

}


$i = 0
$path = "C:\temp\newDirectory\"
$fileName = @()
$iteration = 1
$fileType = ".txt"

for ($i = 0;$i -le 10;$i++){
    $fileName += "Temp_Test_File$($i)$($fileType)"
}

<#
foreach($f in $fileName){
    try{
        New-Item -Path "$($path)\$($f)"
        #throw
    }
    catch{
        <#
        $i = 0 
        Set-AppendFunction -tempPath $path -tempList $f
        #
        write-host "NOPE"
    }
}
#>

function Set-Append1{
    Param
    (
        $testPath,
        $fileArray,
        $iteration
    )
    $j = 1
    
    $tempExt = $fileArray.Substring($fileArray.LastIndexOf('.'),($fileArray.length - $fileArray.indexof('.')))
    $tempFileName = $fileArray.Substring(0,$fileArray.LastIndexOf('.'))
    $tempExt
    $tempFileName
    

    if(Test-Path -path "$($testPath)\$($fileArray)"){
        $iteration++
        # $fileArray = "$($fileArray)$($iteration)" 
        $fileArray = "$($tempFileName)($($iteration))$($tempExt)" 
        $iteration
        $fileArray
        Set-Append1 -testPath $testPath -fileArray $fileArray -iteration $iteration
    }
    else{
        #New-Item "$($testPath)\$($fileArray)"
        write-host "YOU DID IT $($iteration)!!!"
    }
}


foreach($f in $fileName){
    $j = 1
    $newPathName = "$($path)$($f)"
    $newPathName

    Set-Append1 -testPath $path -fileArray $f

   <#
    Set-Append1 -testPath $path -fileArray $f -iteration $j
    #TODO Function Loop
    #>

    <#
    if(test-path -Path "$($path)$($f)"){
        <#
        while(test-path -Path "$($path)\$($f)"){
            #New-Item -Path "$($path)\$($f)$($j)"
            write-host "$($path)\$($f)$($j)"
            $j++
        
        Set-Append1 -

        }
    }
    else{
        new-item -path "$($path)\$($f)"
    }
    #>

}


## HOW TO EXTRACT EXTENSION FROM FILE
## $fileName[0].Substring($fileName[0].LastIndexOf('.'),($fileName[0].length-$fileName[0].indexof('.')))

$tempExt = $fileName[0].Substring($fileName[0].LastIndexOf('.'),($fileName[0].length-$fileName[0].indexof('.')))
$tempFileName = $fileName[0].Substring(0,$fileName[0].LastIndexOf('.'))

