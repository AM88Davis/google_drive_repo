cls

pnputil.exe -i -a "\\camfile1\cam\it\Printer Stuff\Drivers\xrcacor_ppd.inf"

$portName = “IP_10.0.0.51”
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue

if (-not $checkPortExists)
 {
     Add-PrinterPort -name $portName -PrinterHostAddress “10.0.0.51”
 }

Add-Printer -Name "CAM PRINTER Altalink C8135" -DriverName “Xerox AltaLink C8135 PS3” -PortName IP_10.0.0.51
Set-PrintConfiguration -printername "CAM Printer Altalink C8135" -color $false