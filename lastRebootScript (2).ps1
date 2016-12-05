$ImportText = Get-Content -Path C:\Users\klevalley2\Documents\ComputerList.txt

$importCsv = Import-Csv -Path C:\Users\klevalley2\Documents\ComputerList.csv | Select-Object -ExpandProperty ComputerNames

$computers = Invoke-Command -ComputerName $stuff -ScriptBlock {

    $info = Get-WmiObject Win32_OperatingSystem
    $date = $info.ConvertToDateTime($info.LastBootUpTime)
    if ($date.AddDays(1) -gt (Get-Date)){$compliant = $true} else {$compliant = $false}
    return [pscustomobject]@{"Last Boot"=$date; "Name"=$info.PSComputerName;"Compliant"=$compliant}
}

[string]$date = Get-Date -Format FileDate

cd C:\Users\klevalley2\Documents

$computers | ConvertTo-Html -Property "Last Boot", "Name", "Compliant" -Title "Reboot Compliance Report" > $date"test.htm"

$computers | Select-Object -Property "Last Boot", "Name", "Compliant" | Sort-Object -Property "Compliant" | Export-Csv -Path $date"test.csv"