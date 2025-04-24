# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu-dind:latest

USER admin
ENV HOME=/home/admin \
    USER=admin
WORKDIR /home/admin
CMD ["/bin/bash"]

# Copied and modified from the open source IntelliJ-Community Dockerfile.
# The Dind doesn't need to be separate: The base image accupara/ubuntu-dind is enough
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    fontconfig \
    libfreetype6 \
    libgl1-mesa-dev \
    libglx-mesa0 \
    p7zip-full \
    squashfs-tools \
    tar \
    unzip \
    wget \
    zip \
 && sudo rm -rf /var/lib/apt/lists/*
