cls

function Get-IPGeolocation {
  Param
  (
    [string]$IPAddress
  )
 
  $request = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPAddress"
 
  [PSCustomObject]@{
    IP      = $request.query
    City    = $request.city
    Country = $request.country
    Isp     = $request.isp
  }
}
$tempList = @(Import-Csv -Path C:\Temp\DeviceDetailsExport1.csv)
$extList = @()
$i = 0
$deviceInfo = @()

$ComputerIPAddress = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

#Get-IPGeolocation -IPAddress $ComputerIPAddress

#Get-IPGeolocation -IPAddress 174.61.79.56


foreach($t in $tempList){
    #write-host "Your External IP Address is $($t."Ext IP Addr")"
    #Get-IPGeolocation -IPAddress $t."Ext IP Addr"
    #sleep1
    $extList += (Get-IPGeolocation -IPAddress $t."Ext IP Addr")
    $extList[$i]
    $deviceInfo += [PSCustomObject]@{DeviceName = $t.'Device Hostname'; 
                                     ExternalIP = $t.'Ext IP Addr'; 
                                     City = $extList[$i].City; 
                                     County = $extList[$i].Country}
    $i++    
    sleep 1                                          
}

$deviceInfo | Export-Csv -Path "c:\temp\JarvisExternalIPInfo.csv" -NoTypeInformation
$testing = @([PSCustomObject]@{IP = $extList[0].IP})
