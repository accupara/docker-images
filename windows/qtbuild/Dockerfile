# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM us.gcr.io/crave-228104/vstools2019:2019
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

ADD install.ps1 /

RUN powershell.exe /install.ps1 -Wait
