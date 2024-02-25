# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
    bison \
    build-essential \
    curl \
    flex \
    gnupg \
    gperf \
    libncurses5-dev \
    libncurses5 \
    libgl1-mesa-dev \
    libx11-dev \
    libxml2-utils \
    unzip \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
    libfreetype6 \
    brotli \
    openjdk-11-jdk \
# For schedtool (sorted by name)
 && sudo eatmydata apt-get install -y \
    autoconf \
    automake \
    bash \
    bc \
    binutils \
    bison \
    build-essential \
    bzip2 \
    clang \
    cmake \
    cpio \
    curl \
    dialog \
    dos2unix \
    expect \
    flex \
    g++ \
    gawk \
    gcc \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabi \
    gcc-arm-linux-gnueabihf \
    git \
    gperf \
    jq \
    liblz4-tool \
    libncurses5-dev \
    libsdl1.2-dev \
    libssl-dev \
    libstdc++6 \
    libxml2 \
    libxml2-utils \
    lld \
    lldb \
    llvm \
    lzop \
    make \
    neofetch \
    openssl \
    perl \
    pngcrush \
    python2 \
    python3 \
    schedtool \
    sed \
    squashfs-tools \
    tar \
    unzip \
    wget \
    xsltproc \
    zip \
    zlib1g-dev \
    zstd \
# For the dumper
 && sudo eatmydata apt-get install -y \
    python3-venv \
    virtualenv \
# Create a directory for aosp
 && sudo mkdir -p /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
# Remove python 2 completely
 && sudo eatmydata apt-get purge -y python python2.7 \
 && sudo eatmydata apt-get -y autoremove \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
# Make sure that the default version of python is 3
 && if [ $(python --version | grep -c 'Python 3') -eq "0" ] ; then exit 1 ; fi \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Final cleanups
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0