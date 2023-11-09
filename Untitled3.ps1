cls
if (!(test-path $profile))
{
    New-Item -type file -path $profile -force
}