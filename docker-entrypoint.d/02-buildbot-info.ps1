Set-Content -Path (Join-Path ${env:BASEDIR} 'info\admin') -Value (Get-WmiObject -Class Win32_ComputerSystem).Username
Set-Content -Path (Join-Path ${env:BASEDIR} 'info\host') -Value (Get-WmiObject -Class Win32_OperatingSystem).Caption
