# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

# Dependencies as mentioned in https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        build-essential \
        ladspa-sdk \
        libaom-dev \
        libaribb24-dev \
        libass-dev \
        libbluray-dev \
        libbs2b-dev \
        libcaca-dev \
        libcdio-dev \
        libchromaprint-dev \
        libcodec2-dev \
        libdc1394-22-dev \
        libfdk-aac-dev \
        libfontconfig1-dev \
        libfreetype-dev \
        libfribidi-dev \
        libghc-gnutls-dev \
        libgcrypt20-dev \
        liblensfun-dev \
        libmodplug-dev \
        libmp3lame-dev \
        libopencore-amrnb-dev \
        libopencore-amrwb-dev \
        libopencv-dev \
        libopenjp2-7-dev \
        libopenmpt-dev \
        libopus-dev \
        libpulse-dev \
        librabbitmq-dev \
        librsvg2-dev \
        librubberband-dev \
        librtmp-dev \
        libsdl1.2-dev \
        libshine-dev \
        libsnappy-dev \
        libsoxr-dev \
        libspeex-dev \
        libspeexdsp-dev \
        libsrt-dev \
        libssh-dev \
        libtheora-dev \
        libtool \
        libva-dev \
        libvdpau-dev \
        libvorbis-dev \
        libx264-dev \
        libxcb1-dev \
        libxcb-shm0-dev \
        libxcb-xfixes0-dev \
        libzip-dev \
        ninja-build \
        pkg-config \
        texinfo \
        zlib1g-dev \
# These deps are on the same site, but are mentioned separately. Not sure why
 && sudo apt-get install -y \
        libvpx-dev \
        libmp3lame-dev \
        libopus-dev \
        libx264-dev \
        yasm \
# OpenCV needs separate installation
# && cd /tmp ; git clone https://github.com/jayrambhia/Install-OpenCV.git opencv \
# && cd opencv/Ubuntu && 
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
