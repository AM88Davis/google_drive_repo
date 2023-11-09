##CODE TO CATCH EXCEPTION TYPEFULL NAME##

try {
    wr
}
catch [System.Exception] {
    Write-Host "Caught exception: " -NoNewline
    write-host "$($_.Exception.GetType().FullName)" -f darkRed -b White

}

