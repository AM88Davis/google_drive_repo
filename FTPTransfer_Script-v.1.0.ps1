# FTP Transfer to my Tony's FTP Server

$username = "test"
$password = "880550a!"
$filename = "test-4-$($env:COMPUTERNAME)"

$client = New-Object System.Net.WebClient
$client.Credentials = New-Object System.Net.NetworkCredential($username, $password)
$client.UploadFile("ftp://test@173.77.66.16:2121/server/CG_Migration_Files/test4-$($env:COMPUTERNAME).txt", "C:\temp\test_1\Testtesttest.txt")