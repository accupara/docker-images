# Copyright (c) 2018-2019 Crave.io Inc. All rights reserved
FROM microsoft/windowsservercore:1803

# $ProgressPreference: https://github.com/PowerShell/PowerShell/issues/2138#issuecomment-251261324
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ; \
    choco install -y git --params "/GitAndUnixToolsOnPath /NoAutoCrlf"; \
    choco install -y microsoft-build-tools; \
    choco install -y ruby winflexbison python strawberryperl;
