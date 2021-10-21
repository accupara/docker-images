# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
# Remove any previous choco logs so that its easier to read logs later
del C:\ProgramData\chocolatey\logs\chocolatey.log

# Install the ENTIRE 2019 build tools. Eats up at least 60 GB. Takes more than an hour to complete. Give it that time and space.
choco install -y `
    cmake `
    ninja `
    python `
    strawberryperl

# Add tools to the PATH
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name PATH `
    -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path `
         + ";C:\Strawberry\perl\bin")

Write-Output "Installed tools to build Qt"
