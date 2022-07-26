# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install --no-install-recommends -y  \
    build-essential     \
    gcc-multilib        \
    libpcap-dev         \
    linux-headers-generic \
    valgrind \
    && sudo rm -rf /var/lib/apt/lists/*
