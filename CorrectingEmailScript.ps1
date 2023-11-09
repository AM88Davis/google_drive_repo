cls
$osam1 = import-csv -path "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\Validant Project\OSAM_Sites(old).csv"
$osam1.url | ForEach-Object {$osam2 = $osam1.url -replace '.*/'}

$osam3 = for ($i=0;$i -le $osam1.Length; $i++)
{
    #$osam3 = $osam1[$i] | Select-Object *, @{name='CorrectedUrl';expression={"https://validanto365.sharepoint.com/sites/OSAM-$($osam2[$i])"}}

    #$osam1[$i] | Select-Object *, @{name='CorrectedUrl';expression={"WE GOOD"}}
    
    
    if($osam2[$i] -ne $osam1[$i].'"Site name"')
    {
        write-host "ROW [$i]: The URL is wrong at $($osam1[$i].'"Site name"')"
        write-host "UPDATING ON THE NEXT COLUMN" -f black -b DarkYellow
        $osam3 = $osam1[$i] | Select-Object *, @{name='CorrectedUrl';expression={"https://validanto365.sharepoint.com/sites/OSAM-$($osam2[$i])"}}
        $osam3
        
    } 
    else
    {
        write-host "WE ARE GOOD HERE!" -ForegroundColor Blue -b DarkGreen
        $osam3 = $osam1[$i] | Select-Object *, @{Name='CorrectedUrl'; Expression={""}}
        $osam3
    }#| Invoke-Item "-path "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\Validant Project\sample.txt"
    

    #return $osam3
}

$osam3 | format-table

$osam3[3]



#####################
# The operator *, after the Select-Object appends (adds) an extra column all the way to the right
#######################
$osam1 |format-table
$osam3 | format-table


$osam3 | export-csv "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\Validant Project\OSAM_Sites_(Corrected)4.csv" -NoTypeInformation
