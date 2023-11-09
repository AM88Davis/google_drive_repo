[int]$i = 0
$i = 0
$csvTest = @(Import-Csv "C:\temp\atest1.csv" -Header "Word", "Number")

$csvTest1 = $csvTest | Select-Object *, @{name="Extra";expression = {$null}},@{Name="More";expression={$null}}

$tempCO = [pscustomobject] @{
           Name =  $null
           Numbers = $null
           Extra1 = $null
           More1 = $null 
            }

foreach($f in $csvTest1){
    $i++
    write-host $i
    #Write-Host "Hello there $($f.Extra)"
    $f.Extra = "Yep"
    $f.More = $i
}

# The below block declares a variable and basically reassigns the columns different names.

$tempCO1 = foreach ($r in $csvTest1){
    
    [pscustomobject] @{
           Name =  $r.Word
           Numbers = $null
           Extra1 = $null
           More1 = $null 
            } | Select-Object *, @{name='One Last One';expression='0'}


    }

# [pscustomobject] @{$csvTest}

