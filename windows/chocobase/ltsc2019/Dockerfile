# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

ADD install*.ps1 /
RUN powershell.exe /install.ps1 -Wait
