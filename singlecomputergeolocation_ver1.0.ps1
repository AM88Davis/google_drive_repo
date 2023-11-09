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

function Rename-ComputerName{
   Param
   (
     [string]$NewComputerName
   ) 
   
   $ComputerInfo = Get-WmiObject -Class Win32_ComputerSystem
   $ComputerInfo.Rename($NewComputerName) 
}

function Get-CheckForCountrySuffix{
    Param
    (
      [string]$currentComputerName
    )

    if($currentComputerName.Substring(0,3) -in $countryList -or $currentComputerName.Substring(0,2) -in $countryList){
        #write-host "THIS IS TRUE!!!"
        return $true
    }
    else{
        #write-host "This ain't it"
        return $false
    }
    
}


function Set-GeoComputerName{
  Param
  (
    [string] $externalIPAddress,
    [string] $oldComputerName,
    $computerInfo
  )

  $tempCountryAcronym = Get-CountryAcronym -startingCountry $computerInfo.country
  $compSerialNum = Get-WmiObject win32_bios | select Serialnumber
  $newComputerName = $tempCountryAcronym + "-" + $oldComputerName + "-" + $compSerialNum.Serialnumber

  return $newComputerName
}

function Get-CountryAcronym{
  Param
  (
    $startingCountry
  )

     if($startingCountry -eq "United States"){
        return "USA"
     }
     elseif($startingCountry -eq "United Kingdom"){
        return "UK"
     }
     elseif($startingCountry -eq "Philippines"){
        return "PHL"
     }
     elseif($startingCountry -eq "Dominican Republic"){
        return "DR"
     }
     else{
        exit
     }

}


#$tempList = @(Import-Csv -Path C:\Temp\DeviceDetailsExport1.csv)
$extList = @()
$i = 0
$deviceInfo = @()
$countryList = @("USA", "DR", "PHL", "UK")
$computerIPAddress = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

$geoTemp = Get-IPGeolocation -IPAddress $computerIPAddress


$newComputerName = Set-GeoComputerName -externalIPAddress $geoTemp.IP -oldComputerName $env:COMPUTERNAME -computerInfo $geoTemp


if ((Get-CheckForCountrySuffix -currentComputerName $env:COMPUTERNAME) -eq $false){
    Rename-Computer -ComputerName $env:COMPUTERNAME -NewName $newComputerName
    #Rename-ComputerName -NewComputerName $newComputerName
    #Rename-Computer -NewName "ADAVIS-TEMP1"
    Write-Host "New Computer Name is: $($newComputerName)`n`n"
}
else{
    write-host "Your computer name already meets criteria. Exiting program`n"
    exit
}


#$newComputerName

#Rename-Computer -ComputerName $env:COMPUTERNAME -NewName $newComputerName

