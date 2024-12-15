# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

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
# For Ardour
 && sudo eatmydata apt-get -y --no-install-recommends install \
        apt-transport-https \
        curl \
        wget \
        sudo \
        git \
        ca-certificates \
        unzip \
        rsync \
        ed \
        yasm \
        cmake \
        nsis \
        subversion \
        ocaml-nox \
        gperf \
        meson \
        python2 \
        python3 \
        python3-pip \
        build-essential \
        ccache \
        autoconf \
        automake \
        libtool \
        pkg-config \
        libboost-all-dev \
        libjack-dev \
        libglibmm-2.4-dev \
        libsndfile1-dev \
        libarchive-dev \
        liblo-dev \
        libtag1-dev \
        vamp-plugin-sdk \
        librubberband-dev \
        libfftw3-dev \         
        libxml2-dev \
        liblrdf0-dev \
        libsamplerate0-dev \
        lv2-dev \
        libserd-dev \
        libsord-dev \
        libsratom-dev \
        liblilv-dev \
        libgtkmm-2.4-dev \  
        libsoundtouch-dev \
        libsuil-dev \
        libcppunit-dev \
        libusb-1.0-0-dev \
        libwebsockets-dev \
        a2jmidid \
        libjack-dev \
        libcurl4-gnutls-dev \
        libjack0 \
# Create a directory for ardour
 && sudo mkdir -p /opt/ardour \
 && sudo chown admin:admin /opt/ardour \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email ardour@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Final cleanups
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0
