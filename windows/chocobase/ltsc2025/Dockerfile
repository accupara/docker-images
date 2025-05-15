# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM mcr.microsoft.com/dotnet/sdk:9.0-windowsservercore-ltsc2025
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

ADD install*.ps1 /
RUN powershell.exe /install.ps1 -Wait
