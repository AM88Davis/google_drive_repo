#requires -version 2
<#
.SYNOPSIS
  SL-WOW-Fuckup-detector.ps1 is a quick monitoring script meant to be executed from the scheduler on a 
  regular basis. The script will only email the targets in the event it finds a file in the Error folder.

.DESCRIPTION
  Script is intended to be called with credentials from task scheduler capable of viewing the folder. 
  It also requires an anonymous SMTP relay in order to function.

.NOTES
  Version:        1.0
  Creation Date:  7/21/2016
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$FUDScriptVersion = "1.11"

#Log File Info
$FUDLogPath = "C:\Scripts"
$FUDTempLogPath = "C:\Windows\Temp"
$FUDLogName = "FUDStatus.log"
$FUDPath1 = "c:\temp"
$FUDzip = "FUDTempArch.zip"
$FUDTempContentFile1 = "FUDTempContent.txt"
$FUDCompressedFile = "tempFileArchive.zip"
$FUDLogFile = Join-Path -Path $FUDLogPath -ChildPath $FUDLogName
$FUDTempLogFile = Join-Path -Path $FUDpath1 -ChildPath $FUDLogName
$FUDArchiveFile = Join-Path -Path $FUDPath1 -ChildPath $FUDZip
$FUDTempContentFilePath = Join-Path -Path $FUDPath1 -ChildPath $FUDTempContentFile1
$fileRenamingScript = "c:\scripts\ErrorFileRename.ver1.1.ps1"
$timeNow = Get-Date -Format "hhmmss"

# Prefix to exclude and put on the front of files missing the it
$filePrefix = "RE--*"
$oldFilePrefix = "REPORTED*"

#Script Specific Declarations
$FUDPath = "C:\WithoutWire Integration Training\WOWtoSLIntegration\Error"
#$FUDPath = "C:\temp"


# This is the temp path to check. Remove the hastag. Strictly for testing purposes.
#$FUDPath = "C:\WithoutWire Integration Training\WOWtoSLIntegration\Temp"

$FUDStatus = @(Get-ChildItem -Exclude $filePrefix, $oldFilePrefix -path $FUDPath)
# $FUDTarget = @("wowerrors@bpair.com", "anthony.davis@cardenitservices.com", "jeremy.huson@cardenitservices.com",
#               "acolas@bpair.com", "cclark@bpair.com", "tom.ilic@atxadvisory.com")

# Temporarily put an email address in the equotes below to test email functionality
$FUDTarget = @("wowerrors@bpair.com", "cclark@bpair.com", "acolas@bpair.com", "tom.ilic@atxadvisory.com", 
               "anthony.davis@cardenitservices.com")
$FUDTarget = @("anthony.davis@cardenitservices.com")

$SMTPUsername = "fud@bpnyreportmail.com"
$MailFrom = "fud@bpnyreportmail.com"

$login = "fud@bpnyreportmail.com"
$password = "NewY0rk2!" | Convertto-SecureString -AsPlainText -Force
$credentials = New-Object System.Management.Automation.Pscredential -Argumentlist $login,$password


#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#
#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------
# If no error files are found

if($FUDStatus.Length -eq 0) { 
    echo "$(Get-Date -format yyyyMMdd-HHmm)- $env:COMPUTERNAME; version: $FUDScriptVersion; No Errors Found." | Out-File -Append -Encoding ASCII $FUDLogFile
    # Log no found errors
}

else{ 
    Get-ChildItem -Exclude $filePrefix, $oldFilePrefix,*.zip $FUDPath | %{  
    
    $FUDTempPath2 = join-path $FUDPath -ChildPath $_.Name 
    $FUDTempPath2 = $FUDTempPath2 + "<br>" 
    $FUDTempPath2 | Out-File -FilePath $FUDTempContentFilePath -Append    
    
}
    # Creates a .zip file to send the error files over
    Get-childitem -Exclude $filePrefix, $oldFilePrefix, *zip $FUDPath | Compress-Archive -DestinationPath $FUDArchiveFile

    $FUDTempContentFile = Get-Content -Path $FUDTempContentFilePath

    ConvertTo-Html -title "Error File(s) Found: $ENV:COMPUTERNAME" -body (get-date -format yyyyMMdd-HHmm) -pre "<H1>SL-WOW Error(s) Found for: $ENV:COMPUTERNAME </H1><P>SL-WOW ERROR!</P><P>$FUDTempContentFile</P>" -post "<P>Script by Carden IT Services.</P><P></P>" > $ENV:TEMP\FUDstatus.htm 
    Remove-Item -path $FUDTempContentFilePath
    $FUDBody = Get-Content -RAW $ENV:TEMP\FUDstatus.htm
    
# CORRECTED LINE
    Send-MailMessage -From "fud@bpnyreportmail.com" -to $FUDTarget -Subject "SL WOW Error Alert" -Attachments $FUDArchiveFile -BodyAsHtml -Body "$FUDBody" -SmtpServer 66.198.240.53 -Port 2525 -Credential $Credentials

   # Send email report
    
    echo "$(Get-Date -format yyyyMMdd-HHmm)- $env:COMPUTERNAME; version: $FUDScriptVersion; Error File Found. Email Sent." | Out-File -Append -Encoding ASCII $FUDLogFile
    # Log error found and reported
}

Select-String $((Get-Date).addDays(-30).ToString("yyyyMMdd")) $FUDLogFile -notmatch | % {$_.Line} | set-content $FUDTempLogFile
Remove-Item $FUDLogFile
Move-Item $FudTempLogFile $FUDLogFile
# Trim Log File
$i = 0;
Get-ChildItem -Exclude *$filePrefix, *$oldFilePrefix, *.zip $FUDPath | %{

    <#
    test-path -Path "$($FUDPATH)\RE--$($_.name)"
    write-host "$($FUDPATH)\RE--$($_.name)"
    $_.Name
    #>
   
   
    if (!(test-path -Path "$($FUDPath)\$($filePrefix.Substring(0,$filePrefix.Length-1))$($_.Name)")){
        #write-host "$($filePrefix.Substring(0,$filePrefix.Length-1))$($_.Name)"
        Rename-Item $_ -NewName "$($filePrefix.Substring(0,$filePrefix.Length-1))$($_.Name)"
        #write-host "you are good here"
    }
    else{
        Rename-Item $_ -NewName "DUP$($timeNow)$($filePrefix.Substring(0,$filePrefix.Length-1))$($_.Name)"
        #write-host "you are NOT good here"
    }
    
    
    }
    
# change error file to be excluded from the next scan
remove-item -Path $FUDArchiveFile

#$test = "$($filePrefix.Substring(0,$filePrefix.Length-1))$($_.Name)"

## Runs the FILE RENAMING POWERSHELL SCRIPT

#powershell.exe $fileRenamingScript


<#
# Code to remove something (preferably a prefix) from the file. Uncomment

$oldname1 = (Get-ChildItem -Path $FUDPath  | where-Object -Property Name -match "RE--*").Name
foreach ($n in $oldname1){
    $newName = $n.Replace("RE--","")
    $newName
    Rename-Item -Path "$($FUDPath)\$($n)" -NewName $newName
}
#>

