# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
$ErrorActionPreference = 'Stop'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Output "Downloading OpenSSH"
Invoke-WebRequest "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip" -OutFile OpenSSH-Win64.zip -UseBasicParsing

Write-Output "Expanding OpenSSH"
Expand-Archive OpenSSH-Win64.zip C:\\
Remove-Item -Force OpenSSH-Win64.zip

Push-Location C:\\OpenSSH-Win64
Write-Output "Enable logfile"
((Get-Content -path sshd_config_default -Raw) -replace '#SyslogFacility AUTH','SyslogFacility LOCAL0') | Set-Content -Path sshd_config_default
# Write-Output "Disabling password authentication"
# ((Get-Content -path sshd_config_default -Raw) -replace '#PasswordAuthentication yes','PasswordAuthentication no') | Set-Content -Path sshd_config_default

Write-Output "Installing OpenSSH"
& .\\install-sshd.ps1

Write-Output "Generating host keys"
.\\ssh-keygen.exe -A

Write-Output "Fixing host file permissions"
& .\\FixHostFilePermissions.ps1 -Confirm:$false

Write-Output "Fixing user file permissions"
& .\\FixUserFilePermissions.ps1 -Confirm:$false

Pop-Location

Write-Output "Ensure that OpenSSH is in the PATH"
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name PATH `
    -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path `
         + ";C:\\OpenSSH-Win64")

Write-Output "Adding public key to authorized_keys"
$keyPath = "~\\.ssh\\authorized_keys"
New-Item -Type Directory ~\\.ssh > $null
$sshKey | Out-File $keyPath -Encoding Ascii

# Setup openssh server config
Set-Content -Path "C:\ProgramData\ssh\sshd_config" -Value (get-content -Path "C:\OpenSSH-Win64\sshd_config_default" | Select-String -Pattern 'Match Group administrators' -NotMatch)
Set-Content -Path "C:\ProgramData\ssh\sshd_config" -Value (get-content -Path "C:\ProgramData\ssh\sshd_config" | Select-String -Pattern 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys' -NotMatch)

Write-Output "Setting sshd service startup type to 'Manual'"
sc delete sshd
Stop-Service sshd
Set-Service -Name sshd -StartupType Manual
Set-Service -Name ssh-agent -StartupType Manual

# Write-Output "Opening firewall port 22"
# New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH

#Write-Output "Setting sshd service restart behavior"
#sc.exe failure sshd reset= 86400 actions= restart/500
#Start-Service sshd
