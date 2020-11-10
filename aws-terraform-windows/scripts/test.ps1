$URL="https://da3hntz84uekx.cloudfront.net/QlikSense/13.95/0/_MSI/Qlik_Sense_setup.exe"
Invoke-WebRequest $URL -OutFile c:\software\Qlik_Sense_setup.exe

$Username = "digit1"
$Password = "pDigit@!@#@123"
$group = "Administrators"

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
$existing = $adsi.Children | where {$_.SchemaClassName -eq 'user' -and $_.Name -eq $Username }

if ($existing -eq $null) {

    Write-Host "Creating new local user $Username."
    & NET USER $Username $Password /add /y /expires:never
    
    Write-Host "Adding local user $Username to $group."
    & NET LOCALGROUP $group $Username /add

}
else {
    Write-Host "Setting password for existing local user $Username."
    $existing.SetPassword($Password)
}

Write-Host "Ensuring password for $Username never expires."
& WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE



$content = Get-Content -Path 'c:\software\scripts\spec1_cfg.txt'
$newContent = $content -replace 'foo', 'bar'
$newContent | Set-Content -Path 'c:\software\scripts\spec1_cfg.txt'


$filePath = 'C:\file.txt'
$tempFilePath = "$env:TEMP\$($filePath | Split-Path -Leaf)"
$find = 'foo'
$replace = 'bar'

(Get-Content -Path $filePath) -replace $find, $replace | Add-Content -Path $tempFilePath

Remove-Item -Path $filePath
Move-Item -Path $tempFilePath -Destination $filePath