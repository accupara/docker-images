#FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019
FROM mcr.microsoft.com/windows/servercore:20H2

ADD install.ps1 /

RUN powershell.exe /install.ps1 -Wait
