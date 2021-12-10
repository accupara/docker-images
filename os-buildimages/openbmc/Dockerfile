# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    build-essential \
    chrpath \
    diffstat \
    gawk \
    libsdl1.2-dev \
    texinfo \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
