 $File1 = import-csv "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\OsamRenamedSitesCompareNewandOld.csv"
 $File2 = import-csv "G:\My Drive\My Google Documents\Powershell Scripts and Other Projects\MyTestSharepointSandbox.csv"

 
 $i = 0
 $k = 0
 for ($i=0;$k -le $file1.length;$i++)
 {
    
    
    #Write-host "I is equal to $($i)"
    #file1[$i].groupname1
    #write-host "K is equal to $($k)" 
    #$file2[$k].groupname2 
    
    
    if ($File1[$i].groupname1 -eq $file2[$k].groupname2)
    {
          

          write-host "WE HAVE A MATCH! at $($file1[$i].groupname1) and $($file2[$k].groupname2)" -b black
          write-host "NAMES $($File1[$i].NewName) and $($File2[$k].newname)" -b Red -f Yellow
          $k++
          $i = -1
          
     } 
      if ($i -eq $File1.Length+1)
      {
      $i = 0 
      $k = $k +1
      }

      if($k -eq $File1.Length) {break}
       
 }
 
 
 
 
 $file1[0].groupname2
 $file2[0].groupname1
 $file1.count
 $file1.Length+1


 <#
 do
 {    
    $File1[$i].newname
    $i++
 }
 until ($File1[$i].groupname1 -eq $file2[$k].groupname2)
 #>


 for ($i=0;$i -lt 20;$i++)
 {
    
    if ($i -eq 10) {continue}
    write-host $i
 }