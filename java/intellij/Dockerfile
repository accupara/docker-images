# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved

FROM accupara/ubuntu:20.04 AS build_env
# Copied and modified from the open source IntelliJ-Community Dockerfile
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    fontconfig \
    libfreetype6 \
    libgl1-mesa-glx \
    p7zip-full \
    squashfs-tools \
    tar \
    unzip \
    wget \
    zip \
 && rm -rf /var/lib/apt/lists/*
