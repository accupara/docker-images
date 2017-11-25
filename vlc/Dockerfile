# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:17.10
MAINTAINER Accupara Inc. "contact@accupara.com"

# Enable the Ubuntu multiverse repository.
RUN sudo apt-get update \
 && sudo apt-get install -y \
        build-essential \
        ca-certificates \
        dh-buildinfo \
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
        locales \
        make \
        openjdk-8-jdk \
        openssh-server \
        qtbase5-private-dev \
        snapcraft \
        wayland-protocols \
 && sudo apt-get build-dep -y vlc \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo locale-gen en_US.UTF-8 \
 && sudo /usr/sbin/update-locale LANG=en_US.UTF-8

 ENV LANG=en_US.UTF-8
