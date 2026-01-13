# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install --no-install-recommends -y  \
    build-essential     \
    gcc-multilib        \
    libpcap-dev         \
    linux-headers-generic \
    valgrind \
    && sudo rm -rf /var/lib/apt/lists/*
