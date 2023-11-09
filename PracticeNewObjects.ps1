###########################
#New Object Practice Sheet#
###########################

."C:\temp\write-hostandlog(function).ps1"

$testObject = [pscustomobject]@{Name = 'Johnson Wallace'; Age = 23; Birthday = 'October 29, 1988'}
$testNew = $testObject | Select-Object Name, @{Name = 'Address'; Expression = {'123 Fake St.'}}, Age 
$testNew2 = $testObject | select-object *, @{Name = 'Address'; Expression = {'321 Faux Pl.'}}
$nameArray = @()

#Below is the same as above, just a different way of writing it.
$newObject1 =  New-Object -TypeName Psobject -Property @{Name = "William Henry"; Age = 23; Birthday = 'April 24, 2022'}

$newObject2 = New-Object System.int32 

$testObject | Get-Member

$testobject.Name | get-member
($testObject.name).Trim('J', ' ', 'o', 'n', 'e', 'W')
trim($testObject.name)
$testObject.name.ToUpper()
$testObject.name.gethashcode()
$tempName = $testObject.name.Remove(1)
$nameArray = $testObject.name.Split(' ')

get-childitem | Where-Object {$_.Name -like "adv*"} | select name

Write-HostandLog "Hello"