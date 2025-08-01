# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved

# The old deps were specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
# New information is at https://firefox-source-docs.mozilla.org/setup/linux_build.html#building-firefox-on-linux
FROM accupara/ubuntu:24.04

COPY kb-config.exp /tmp/

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y \
    curl \
    mercurial \
    python3 \
    python3-pip \
 #&& sudo apt-get install -y expect \
 #&& sudo expect /tmp/kb-config.exp \
 && mkdir -p /tmp/src && cd /tmp/src \
# Get cinnabar first
 && curl https://raw.githubusercontent.com/glandium/git-cinnabar/master/download.py -O \
 && python3 download.py \
 && sudo mv git-cinnabar git-remote-hg /usr/bin/ \
# Clone the sources into /tmp/src/mozilla-unified
 && git clone --depth=1 https://github.com/mozilla-firefox/firefox mozilla-unified \
# Go into the sources and then mach bootstrap
 && cd mozilla-unified \
 && ./mach --no-interactive bootstrap --application-choice browser \
# Don't keep any of the sources in the container. Just the deps need installation
 && cd /tmp \
 && sudo find src -delete \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/bash \
    PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    MOZBUILD_STATE_PATH=/home/admin/.mozbuild
