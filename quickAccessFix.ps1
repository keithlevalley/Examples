#Detection

# Checks to see if anything exists inside the Default Desktop
$files = Get-ChildItem -Path "C:\Users\Default\Desktop" -Name
if ($files.Count -gt 0)
{
    echo $True
} else {echo $false}


#Remediation

# Gets all the users excluding the Public user
$users = Get-ChildItem -Path "C:\Users" -Name -Exclude "Public"

# Creates a folder called ArchivedDocs + UserName for every user
foreach ($user in $users)
{
    New-Item "C:\ArchivedDocs" -Name $user"_Archive" -ItemType Directory -ErrorAction SilentlyContinue
}

# Get all the files inside the Default Desktop
$files = Get-ChildItem -Path "C:\Users\Default\Desktop" -File -Name

# For every user, if a file in the default desktop exists on the users desktop then move that file to the archivedDocs folder
foreach ($user in $users)
{
    $temp = $user+"_Archive"

    foreach ($file in $files)
    {
        Move-Item -Path "C:\Users\$user\Desktop\$file" -Destination "C:\ArchivedDocs\$temp\$file" -Verbose -ErrorAction SilentlyContinue
    }


}

# Do the same thing as above for the default folder
if (-not $users.Contains("default"))
{
    New-Item "C:\ArchivedDocs" -Name "Default" -ItemType Directory

    foreach ($file in $files)
    {
        Move-Item -Path "C:\Users\Default\Desktop\$file" -Destination "C:\ArchivedDocs\Default\$file" -Verbose -ErrorAction Continue
    }
}

# Remove access rights to the ArchivedDocs folder.  This is probably bad code...but it works
$Acl = Get-Acl -Path "C:\ArchivedDocs"

$Ar = $acl.Access | Where-Object -Property IdentityReference -EQ "BUILTIN\Users"

$acl.SetAccessRuleProtection($True, $false)

$Acl.RemoveAccessRuleSpecific($Ar)

Set-Acl -Path "C:\ArchivedDocs" -AclObject $Acl
