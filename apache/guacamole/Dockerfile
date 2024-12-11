# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# Dependencies captured in the readme.md at https://github.com/apache/guacamole-server

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    automake \
    ffmpeg \
    freerdp2-dev \
    libcairo2-dev \
    libjpeg-dev \
    libpng-dev \
    libpulse-dev \
    libossp-uuid-dev \
    libssh-dev \
    libssl-dev \
    libtelnet-dev \
    libvncserver-dev \
    libwebp-dev \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
