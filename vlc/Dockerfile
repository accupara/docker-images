# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/debian:9
MAINTAINER Crave.io Inc. "contact@crave.io"

# Enable the Ubuntu multiverse repository.
RUN sudo bash -c 'echo "deb-src http://security.debian.org stretch/updates main" >> /etc/apt/sources.list' \
 && sudo bash -c 'echo "deb http://ftp.debian.org/debian/ stretch main" >> /etc/apt/sources.list' \
 && sudo bash -c 'echo "deb-src http://ftp.debian.org/debian/ stretch main" >> /etc/apt/sources.list' \
 && sudo bash -c 'echo "deb http://ftp.debian.org/debian stretch-updates main" >> /etc/apt/sources.list' \
 && sudo bash -c 'echo "deb-src http://ftp.debian.org/debian stretch-updates main" >> /etc/apt/sources.list' \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        autopoint \
        bison \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        dh-buildinfo \
        dos2unix \
        flex \
        gettext \
        git-core \
        lftp \
        libavcodec-dev \
        libavformat-dev \
        libdirectfb-dev \
        liblircclient-dev \
        libmodplug-dev \
        libpostproc-dev \
        libqt5svg5-dev \
        libswscale-dev \
        libtool \
        locales \
        make \
        openjdk-8-jdk \
        openssh-server \
        p7zip-full \
        pkg-config \
        qtbase5-private-dev \
        snapd \
        subversion \
        wayland-protocols \
        wget \
        zip \
 && sudo apt-get build-dep -y vlc \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
