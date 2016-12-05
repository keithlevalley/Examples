Start-Process C:\Users\klevalley2\Desktop\Powershell.pptx

Get-NetAdapter

Get-NetAdapter | Get-Member

Get-NetAdapter -Name Local* | Select-Object -Property *

Get-NetAdapter | Where-Object {$_.Status -eq "Disconnected"}

Get-Help *adapter*

Get-Command -Noun NetAdapter

Get-Help Restart-NetAdapter

Get-Help Enable-NetAdapter -Full

Get-Help Disable-NetAdapter -ShowWindow

Get-NetAdapter

Get-NetAdapter | Where-Object {$_.Status -eq "Disconnected"} | Disable-NetAdapter

Get-NetAdapter | Where-Object {$_.Status -eq "Disabled"} | Enable-NetAdapter

$IE=new-object -ComObject internetexplorer.application
$IE.navigate2("https://github.com/dotps1/PSGist")
$IE.visible=$true

Uninstall-Module PSGist

Install-Module PSGist

Get-Command -Noun *gist*

New-GistOAuthToken

New-Gist -IseScriptPane -Public | Select-Object -Property UpdatedAt, HtmlUrl