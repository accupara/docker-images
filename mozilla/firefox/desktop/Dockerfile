# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

# The old deps were specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
# New information is at https://firefox-source-docs.mozilla.org/setup/linux_build.html#building-firefox-on-linux
FROM accupara/ubuntu:22.04

COPY kb-config.exp /tmp/

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y \
    curl \
    python3 \
    python3-pip \
 #&& sudo apt-get install -y expect \
 #&& sudo expect /tmp/kb-config.exp \
 && mkdir -p /tmp/src && cd /tmp/src \
 && curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O \
 && sudo python3 bootstrap.py --vcs=git --no-interactive \
# Don't keep any of the sources in the container. Just the deps need installation
 && sudo find . -delete \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/bash \
    PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
