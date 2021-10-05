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
    jq `
    vim

choco install openssh -y -params '"/SSHServerFeature"'
#Setup openssh server config
Set-Content -Path "C:\ProgramData\ssh\sshd_config" -Value (get-content -Path "C:\ProgramData\ssh\sshd_config" | Select-String -Pattern 'Match Group administrators' -NotMatch)
Set-Content -Path "C:\ProgramData\ssh\sshd_config" -Value (get-content -Path "C:\ProgramData\ssh\sshd_config" | Select-String -Pattern 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys' -NotMatch)

#Make sshd not run automatically
sc delete sshd
Stop-Service sshd
Set-Service -Name sshd -StartupType Manual


# Add things to the PATH
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name PATH `
    -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path `
         + ";C:\Program Files\Git\bin\" `
         + ";C:\tools\vim\vim82\")

