# Start off by installing Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Needed by vstools and others
choco install -y dotnetfx

# Needed by the rest of Crave
choco install -y `
    git `
    make `
    rsync `
    vim

# Add things to the PATH
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name PATH `
    -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path `
         + ";C:\Program Files\Git\bin\" `
         + ";C:\tools\vim\vim82\")
