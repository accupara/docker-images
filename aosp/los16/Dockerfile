# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

ENV YQ_VER=4.40.3 \
    REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
    bc \
    bison \
    build-essential \
    curl \
    flex \
    gcc-arm-linux-gnueabi \
    gcc-arm-linux-gnueabihf \
    g++-multilib \
    gcc-multilib \
    gnupg \
    gperf \
    git \
    git-lfs \
    imagemagick \
    lib32ncurses5-dev \
    lib32readline-dev \
    lib32z1-dev \
    libelf-dev \
    liblz4-tool \
    lib32ncurses5-dev \
    libncurses5-dev \
    libncurses5 \
    libfreetype6 \
    libsdl1.2-dev \
    libssl-dev \
    libxml2 \
    libxml2-utils \
    lzop \
    pngcrush \
    python2 \
    rsync \
    schedtool \
    squashfs-tools \
    unzip \
    xsltproc \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
# Use python2
 && sudo ln -s /bin/python2.7 /usr/bin/python \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Save the resync.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/ \
 && sudo chown admin:admin /opt/crave/ \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/resync.sh -O /opt/crave/resync.sh \
 && chmod +x /opt/crave/resync.sh \
# Save the upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/github-actions \
 && sudo chown admin:admin /opt/crave/github-actions \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/upload.sh -O /opt/crave/github-actions/upload.sh \
 && chmod +x /opt/crave/github-actions/upload.sh \
 # Save the telegram upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/telegram \
 && sudo chown -R admin:admin /opt/crave \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/tgup.sh -O /opt/crave/telegram/upload.sh \
 && chmod +x /opt/crave/telegram/upload.sh \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
