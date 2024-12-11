# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install --no-install-recommends -y  \
    build-essential \
    libpcap-dev \
    linux-headers-generic \
 && sudo rm -rf /var/lib/apt/lists/*

ENV RTE_KERNELDIR /usr/src/linux-headers-4.4.0-64-generic

# Compile using "make config T=x86_64-native-linuxapp-gcc && make"
