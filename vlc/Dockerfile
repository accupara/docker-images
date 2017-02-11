# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/qt4:latest
MAINTAINER Accupara Inc. "contact@accupara.com"

# Enable the Ubuntu multiverse repository.
RUN sudo bash -c 'echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/source.list' && \
    sudo bash -c 'echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse">> /etc/apt/source.list' && \
    sudo bash -c 'echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/source.list' && \
sudo bash -c 'echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/source.list'

RUN sudo apt-get update && \
    sudo apt-get install -y \
        autoconf \
        automake \
        build-essential \
        checkinstall \
        git \
        wget \
        yasm

RUN sudo apt-get install -y \
    liba52-0.7.4-dev \
    libaa1-dev \
    libasound2-dev \
    libass-dev \
    libavahi-client-dev \
    libcaca-dev \
    libcairo2-dev \
    libcddb2-dev \
    libcdio-dev \
    libdca-dev \
    libdvbpsi-dev \
    libdvdnav-dev \
    libdvdread-dev \
    libebml-dev \
    libfaad-dev \
    libflac-dev \
    libfluidsynth-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgcrypt11-dev \
    libgl1-mesa-dev \
    libglib2.0-0 \
    libgnomevfs2-dev \
    libgnutls-dev \
    libid3tag0-dev \
    libjack-jackd2-dev \
    libkate-dev \
    liblircclient-dev \
    liblua5.1-0-dev \
    libmad0-dev \
    libmatroska-dev \
    libmodplug-dev \
    libmpcdec-dev \
    libmpeg2-4-dev \
    libmtp-dev \
    libncursesw5-dev \
    libnotify-dev \
    libogg-dev \
    liboggkate-dev \
    libpango1.0-dev \
    libpng12-dev \
    libprojectm-dev \
    libprojectm-qt-dev \
    libproxy-dev \
    libpulse-dev \
    libraw1394-dev \
    librsvg2-dev \
    libschroedinger-dev \
    libsdl-image1.2-dev \
    libsdl1.2-dev \
    libshout3-dev \
    libsmbclient-dev \
    libspeex-dev \
    libsqlite3-dev \
    libsysfs-dev \
    libtag1-dev \
    libtar-dev \
    libgme-dev \
    libtheora-dev \
    libtool \
    libtwolame-dev \
    libudev-dev \
    libupnp-dev \
    libv4l-dev \
    libva-dev \
    libvcdinfo-dev \
    libvorbis-dev \
    libvpx-dev \
    libx11-dev \
    libx11-xcb-dev \
    libxcb-composite0-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-shm0-dev \
    libxcb-xv0-dev \
    libxcb-xvmc0-dev \
    libxcb1-dev \
    libxext-dev \
    libxml2-dev \
    libxpm-dev \
    libxt-dev \
    libxv-dev \
    libzvbi-dev lua5.1 qt4-qtconfig \
    libspeexdsp-dev \
    libsamplerate0-dev 

#    libdirac-dev \
#    libhal-dev \
#    libggi2-dev \
#    libsvga1-dev \

# Compile ffmpeg (cheating?)
RUN sudo apt-get -y install \
    libmp3lame-dev \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    zlib1g-dev && \
    mkdir /tmp/vlc_build && \
    cd /tmp/vlc_build && \
    wget http://ffmpeg.org/releases/ffmpeg-1.1.1.tar.bz2 && \
    tar xjvf ffmpeg-1.1.1.tar.bz2 && cd ffmpeg-1.1.1 && \
    if [ "$(uname -m)" = "x86_64" ]; then \
        ARCHOPTS="--enable-pic" ; \
    else \
        ARCHOPTS="" ; \
    fi && \
    ./configure --prefix=/tmp/vlc_build/vlcdeps/usr \
              $ARCHOPTS \
              --enable-gpl \
              --enable-version3 \
              --enable-nonfree \
              --enable-postproc \
              --enable-pthreads \
              --enable-libmp3lame \
              --enable-libopencore-amrnb \
              --enable-libopencore-amrwb \
              --enable-libvpx \
              --disable-ffmpeg \
              --disable-ffplay \
              --disable-ffserver \
              --disable-doc && \
    make && \
    sudo make install-libs install-headers && \
    make distclean && \
    rm -rf /tmp/vlc_build/ffmpeg-1.1.1

# Removed from the configure script for ffmpeg
#              --enable-libfaac \
# Removed from the install deps for ffmpeg
#    libfaac-dev \
