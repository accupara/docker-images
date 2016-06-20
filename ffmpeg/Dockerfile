# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

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
        libmp3lame-dev \
        libopus-dev \
        libx264-dev \
        yasm
