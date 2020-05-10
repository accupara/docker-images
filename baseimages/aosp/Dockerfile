# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get -y install \
    bison \
    build-essential \
    curl \
    flex \
    g++-multilib \
    gcc-multilib \
    gnupg \
    gperf \
    lib32ncurses5-dev \
    lib32z-dev \
    libc6-dev-i386 \
    libgl1-mesa-dev \
    libx11-dev \
    libxml2-utils \
    unzip \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
# Get the latest version of repo
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mkdir /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
