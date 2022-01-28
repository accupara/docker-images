# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

# "set -x"
#Set-PSDebug -Trace 1

# Start off by installing Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Needed by vstools and others
choco install -y dotnetfx

# Needed by the rest of Crave
choco install -y `
    emacs `
    git `
    make `
    rsync `
    jq `
    vim

del C:\ProgramData\chocolatey\logs\chocolatey.log

# Install the openssh server using a script that is based on the one from: https://github.com/StefanScherer/dockerfiles-windows/blob/main/openssh/install-openssh.ps1
/install-openssh.ps1

# Add tools to the PATH
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name PATH `
    -Value ("C:\OpenSSH-Win64;" `
         + (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path `
         + ";C:\Program Files\Git\bin\" `
         + ";C:\ProgramData\chocolatey\lib\Emacs\tools\emacs\bin" `
         + ";C:\ProgramData\chocolatey\lib\make\tools\install\bin" `
         + ";C:\ProgramData\chocolatey\lib\jq\tools" `
         + ";C:\ProgramData\chocolatey\lib\rsync\tools\cwrsync_6.2.4_x64_free\bin" `
         + ";C:\tools\vim\vim82\")

Write-Output "Installation complete"
