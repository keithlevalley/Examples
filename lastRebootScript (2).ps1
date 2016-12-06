# Saving the file path as a variable to clean up the code a little
$filePath = "C:\Users\klevalley2\Documents\PowerShell Training"

# Pulls in a Text file and saves it as the variable PCList
$PCList = Get-Content -Path "$filePath\ComputerList.txt"

# Pulls in a CSV file, extracts the "ComputerNames property (heading) as plain strings and saves it as the variable PCList
$PCList = Import-Csv -Path "$filePath\ComputerList.csv" | Select-Object -ExpandProperty ComputerNames

# This is the cool stuff
# Going to each PC in the array computers and extracting the win32_OperatingSystem info.  Grabs the LastBootUpTime
# and returns that back as actual object with properties of "Last Boot", "Name", and "Compliant" and saves those
# objects (pointers??) as the variable computers
$computerInfo = Invoke-Command -ComputerName $PCList -ScriptBlock {

    $info = Get-WmiObject Win32_OperatingSystem
    $date = $info.ConvertToDateTime($info.LastBootUpTime)
    if ($date.AddDays(1) -gt (Get-Date)){$compliant = $true} else {$compliant = $false}
    return [pscustomobject]@{"Last Boot"=$date; "Name"=$info.PSComputerName;"Compliant"=$compliant}
}

# Using the Get-Date commandlet to get and format current date
[string]$date = Get-Date -Format FileDate

# Changes to directory where I want to save reports
cd $filePath

# Saves the report as an Html File including the date as part of the name
$computerInfo | ConvertTo-Html -Property "Last Boot", "Name", "Compliant" -Title "Reboot Compliance Report" > $date"lastboot.htm"

# Saves the report as a CSV File including the date as part of the name
$computerInfo | Select-Object -Property "Last Boot", "Name", "Compliant" | Sort-Object -Property "Compliant" | Export-Csv -Path $date"lastboot.csv"
