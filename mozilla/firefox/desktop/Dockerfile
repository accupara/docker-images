# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
# From the deps specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    autoconf2.13 \
    binutils-avr \
    build-essential \
    cargo \
    clang \
    fontconfig \
    git \
    libasound2-dev \
    libdbus-glib-1-dev \
    libfreetype6 \
    libgconf2-dev \
    libgl1-mesa-dev \
    libgstreamer1.0-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    libidl-dev \
    libnotify-dev \
    libpulse-dev \
    libxt-dev \
    mercurial \
    perl \
    pkg-config \
    python2.7 \
    wget \
    yasm \
    zip \
# Run the bootstrap script
 && cd /tmp/ ; wget https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py \
 && export MOZBUILD_STATE_PATH=/opt/mozbuild \
 && sudo mkdir /opt/mozbuild && sudo chown admin:admin /opt/mozbuild \
 && echo 2 | python bootstrap.py --no-interactive || true \
# Mercurial must be at the latest version
 && sudo apt-get purge -y mercurial mercurial-common \
 && cd /tmp/ \
 && wget http://security.ubuntu.com/ubuntu/pool/universe/m/mercurial/mercurial-common_4.8.2-1ubuntu3_all.deb \
 && wget http://security.ubuntu.com/ubuntu/pool/universe/m/mercurial/mercurial_4.8.2-1ubuntu3_amd64.deb \
 && sudo dpkg -i /tmp/mercurial-common_4.8.2-1ubuntu3_all.deb \
 && sudo dpkg -i /tmp/mercurial_4.8.2-1ubuntu3_amd64.deb \
 && rm /tmp/mercurial-common_4.8.2-1ubuntu3_all.deb /tmp/mercurial_4.8.2-1ubuntu3_amd64.deb \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

 ENV SHELL=/bin/bash \
     PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
