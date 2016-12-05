#Detection
$files = Get-ChildItem -Path "C:\Users\Default\Desktop" -Name
if ($files.Count -gt 0)
{
    echo $True
} else {echo $false}


#Remidiation

$users = Get-ChildItem -Path "C:\Users" -Name -Exclude "Public"

foreach ($user in $users)
{
    New-Item "C:\ArchivedDocs" -Name $user"_Archive" -ItemType Directory -ErrorAction SilentlyContinue
}

$files = Get-ChildItem -Path "C:\Users\Default\Desktop" -File -Name

foreach ($user in $users)
{
    $temp = $user+"_Archive"

    foreach ($file in $files)
    {
        Move-Item -Path "C:\Users\$user\Desktop\$file" -Destination "C:\ArchivedDocs\$temp\$file" -Verbose -ErrorAction SilentlyContinue
    }


}

if (-not $users.Contains("default"))
{
    New-Item "C:\ArchivedDocs" -Name "Default" -ItemType Directory

    foreach ($file in $files)
    {
        Move-Item -Path "C:\Users\Default\Desktop\$file" -Destination "C:\ArchivedDocs\Default\$file" -Verbose -ErrorAction Continue
    }
}

$Acl = Get-Acl -Path "C:\ArchivedDocs"

$Ar = $acl.Access | Where-Object -Property IdentityReference -EQ "BUILTIN\Users"

$acl.SetAccessRuleProtection($True, $false)

$Acl.RemoveAccessRuleSpecific($Ar)

Set-Acl -Path "C:\ArchivedDocs" -AclObject $Acl