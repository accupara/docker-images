# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# From the deps specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
FROM accupara/ubuntu:20.04

COPY kb-config.exp /tmp/

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y expect \
 && sudo expect /tmp/kb-config.exp \
 && sudo apt-get install -y \
    autoconf2.13 \
    binutils-avr \
    build-essential \
    cargo \
    clang \
    fontconfig \
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
    python3 \
    yasm \
    zip \
# Mercurial must be at the latest version
 && sudo apt-get purge -y mercurial mercurial-common \
 && cd /tmp/ \
 && wget -q http://security.ubuntu.com/ubuntu/pool/universe/m/mercurial/mercurial_5.3.1-1ubuntu1_amd64.deb \
            http://security.ubuntu.com/ubuntu/pool/universe/m/mercurial/mercurial-common_5.3.1-1ubuntu1_all.deb \
 && sudo dpkg -i /tmp/mercurial-common_5.3.1-1ubuntu1_all.deb \
 && sudo dpkg -i /tmp/mercurial_5.3.1-1ubuntu1_amd64.deb \
# Run the bootstrap script
 && cd /tmp/ ; wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py \
 && export MOZBUILD_STATE_PATH=/opt/mozbuild \
 && sudo mkdir /opt/mozbuild && sudo chown admin:admin /opt/mozbuild \
 && echo 2 | python3 bootstrap.py --no-interactive || true \
# Cleanup
 && rm -f /tmp/*deb \
 && rm -rf /tmp/mozilla* \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/bash \
    PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
