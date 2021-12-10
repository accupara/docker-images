# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

## NOTE: Ubuntu 18.04 is required because bitbake needs python 3.6 and Ubuntu 14.04 only has 3.4 and 16.04 has only 3.5

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    build-essential \
    chrpath \
    cpio \
    diffstat \
    gawk \
    liblz4-tool \
    libsdl1.2-dev \
    texinfo \
    zstd \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
