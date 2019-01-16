# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Enable the Ubuntu multiverse repository.
RUN sudo bash -c 'echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/source.list' && \
    sudo bash -c 'echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse">> /etc/apt/source.list' && \
    sudo bash -c 'echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/source.list' && \
    sudo bash -c 'echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/source.list'

# Dependencies as mentioned in https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
RUN sudo apt-get update && \
    sudo apt-get install -y \
        autoconf \
        automake \
        build-essential \
        libass-dev \
        libfreetype6-dev \
        libsdl1.2-dev \
        libtheora-dev \
        libtool \
        libva-dev \
        libvdpau-dev \
        libvorbis-dev \
        libxcb1-dev \
        libxcb-shm0-dev \
        libxcb-xfixes0-dev \
        pkg-config \
        texinfo \
        zlib1g-dev

# These deps are on the same site, but are mentioned separately. Not sure why
RUN sudo apt-get install -y \
        libvpx-dev \
        libmp3lame-dev \
        libopus-dev \
        libx264-dev \
        yasm
