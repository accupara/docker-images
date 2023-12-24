# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

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
