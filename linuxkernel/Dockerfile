# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        clang \
        cpio \
        flex \
        libelf-dev \
        libncurses5-dev \
        libssl-dev \
        openssl \
        perl \
        gawk \
        qemu-kvm \
 && sudo eatmydata apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
