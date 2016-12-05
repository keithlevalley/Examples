#Detection Method

$users = Get-ChildItem -Path "C:\Users" -Name
$path = "appdata\roaming\microsoft\windows\Recent\AutomaticDestinations"
$run = $false

foreach ($user in $users)
{
    if ((Test-Path -Path "C:\Users\$user\$path\5f7b5f1e01b83767.automaticDestinations-ms") -or (Test-Path -Path "C:\Users\$user\$path\f01b4d95cf55d32a.automaticDestinations-ms"))
    {
        $run = $true
    }
}

if ((Test-Path -Path "C:\Users\Default\$path\5f7b5f1e01b83767.automaticDestinations-ms") -or (Test-Path -Path "C:\Users\Default\$path\f01b4d95cf55d32a.automaticDestinations-ms"))
{
    $run = $true

}

if ($run -eq $true) {echo $true} else {echo $false}

#Remediation Method

$users = Get-ChildItem -Path "C:\Users" -Name
$path = "appdata\roaming\microsoft\windows\Recent\AutomaticDestinations"

foreach ($user in $users)
{
    if (Test-Path -Path "C:\Users\$user\$path\5f7b5f1e01b83767.automaticDestinations-ms")
    {
        Remove-Item "C:\Users\$user\$path\5f7b5f1e01b83767.automaticDestinations-ms"
    }

    if (Test-Path -Path "C:\Users\$user\$path\f01b4d95cf55d32a.automaticDestinations-ms")
    {
        Remove-Item "C:\Users\$user\$path\f01b4d95cf55d32a.automaticDestinations-ms"
    }
}

if (Test-Path -Path "C:\Users\Default\$path\5f7b5f1e01b83767.automaticDestinations-ms")
{
    Remove-Item "C:\Users\Default\$path\5f7b5f1e01b83767.automaticDestinations-ms"
}

if (Test-Path -Path "C:\Users\Default\$path\f01b4d95cf55d32a.automaticDestinations-ms")
{
    Remove-Item "C:\Users\Default\$path\f01b4d95cf55d32a.automaticDestinations-ms"
}