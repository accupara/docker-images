# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

ADD install.ps1 install-openssh.ps1 /

RUN powershell.exe /install.ps1 -Wait
