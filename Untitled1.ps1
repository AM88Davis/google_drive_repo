set-ExecutionPolicy -scope localmachine -ExecutionPolicy Unrestricted 
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https:\\8cbqf0.sharepoint.com" 
Import-PSSession $Session