# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

RUN set -x \
 && sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository -y ppa:beineri/opt-qt-5.13.2-bionic \
 && sudo apt-get update \
 && sudo apt-get -y build-dep vlc vlc-plugin-qt \
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
        freerdp2-dev \
        gettext \
        git-core \
        lftp \
        liba52-0.7.4-dev \
        libarchive-dev \
        libaribb24-dev \
        libasound2-dev \
        libass-dev \
        libavcodec-dev \
        libavc1394-dev \
        libavformat-dev \
        libbluray-dev \
        libcaca-dev \
        libcddb2-dev \
        libchromaprint-dev \
        libdvbpsi-dev \
        libdc1394-22-dev \
        libdca-dev \
        libdirectfb-dev \
        libdvdnav-dev \
        libdvdread-dev \
        libebml-dev \
        libfaad-dev \
        libflac++-dev \
        libfluidsynth-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libfribidi-dev \
        libgme-dev \
        libharfbuzz-dev \
        libkate-dev \
        libjpeg-dev \
        liblircclient-dev \
        liblivemedia-dev \
        liblua5.2-dev \
        libmad0-dev \
        libmatroska-dev \
        libmodplug-dev \
        libmpeg2-4-dev \
        libmpg123-dev \
        libncursesw5-dev \
        libnfs-dev \
        libogg-dev \
        liboggkate-dev \
        libopencv-dev \
        libopus-dev \
        libpng-dev \
        libpostproc-dev \
        libpulse-dev \
        libqt5gstreamer-dev \
        libqt5quick5 \
        libqt5quickcontrols2-5 \
        libqt5quickwidgets5 \
        libqt5svg5-dev \
        libqt5x11extras5-dev \
        libraw1394-dev \
        libsamplerate0-dev \
        libsdl-image1.2-dev \
        libshine-dev \
        libsidplay2-dev \
        libsmbclient-dev \
        libsoxr-dev \
        libspeex-dev \
        libspeexdsp-dev \
        libssh2-1-dev \
        libsvgpp-dev \
        libswscale-dev \
        libtheora-dev \
        libtool \
        libtwolame-dev \
        libva-dev \
        libvdpau-dev \
        libvncclient1 \
        libvncserver-dev \
        libvorbis-dev \
        libvpx-dev \
        libwayland-dev \
        libwbclient-dev \
        libx264-dev \
        libx265-dev \
        libxcb1-dev \
        libxcb-composite0-dev \
        libxcb-randr0-dev \
        libxcb-shm0-dev \
        libxcb-xkb-dev \
        libxcursor-dev \
        libxext-dev \
        libxinerama-dev \
        libxml2-dev \
        libxpm-dev \
        libzvbi-dev \
        locales \
        lua5.2 \
        make \
        openjdk-8-jdk \
        openssh-server \
        oss4-dev \
        p7zip-full \
        pkg-config \
        qt513-meta-minimal \
        qt513quickcontrols \
        qt513quickcontrols2 \
        qt513svg \
        qt513x11extras \
        snapd \
        subversion \
        wayland-protocols \
        wget \
        zip \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8

#RUN set -x \
# && sudo apt-get update \
# && sudo apt-get install -y
