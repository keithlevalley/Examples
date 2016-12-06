#Detection Method

# Save some variables to make script cleaner
$users = Get-ChildItem -Path "C:\Users" -Name
$path = "appdata\roaming\microsoft\windows\Recent\AutomaticDestinations"
$run = $false

# .NET Foreach runs code block on each item inside collection/list/array
foreach ($user in $users)
{
    # Checks to see if either file exists, if one does exist it sets run = true
    if ((Test-Path -Path "C:\Users\$user\$path\5f7b5f1e01b83767.automaticDestinations-ms") -or (Test-Path -Path "C:\Users\$user\$path\f01b4d95cf55d32a.automaticDestinations-ms"))
    {
        $run = $true
    }
}

# Check specifically for default folder as folder is hidden
if ((Test-Path -Path "C:\Users\Default\$path\5f7b5f1e01b83767.automaticDestinations-ms") -or (Test-Path -Path "C:\Users\Default\$path\f01b4d95cf55d32a.automaticDestinations-ms"))
{
    $run = $true
}

# Made for SCCM which requires that you use echo instead of return keyword
if ($run -eq $true) {echo $true} else {echo $false}

#Remediation Method

# Saves some variables as paths to make code cleaner
$users = Get-ChildItem -Path "C:\Users" -Name
$path = "appdata\roaming\microsoft\windows\Recent\AutomaticDestinations"

# Goes through every user and deletes the files if they exist
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

# Does the same thing for default folder
if (Test-Path -Path "C:\Users\Default\$path\5f7b5f1e01b83767.automaticDestinations-ms")
{
    Remove-Item "C:\Users\Default\$path\5f7b5f1e01b83767.automaticDestinations-ms"
}

if (Test-Path -Path "C:\Users\Default\$path\f01b4d95cf55d32a.automaticDestinations-ms")
{
    Remove-Item "C:\Users\Default\$path\f01b4d95cf55d32a.automaticDestinations-ms"
}
