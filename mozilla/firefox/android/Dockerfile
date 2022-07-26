# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# From the deps specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
FROM accupara/firefox:desktop

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    openjdk-8-jdk-headless \
    python3-pip \
 && cd /tmp/ \
 && export MOZBUILD_STATE_PATH=/opt/mozbuild \
 && echo 4 | python3 bootstrap.py --no-interactive \
 && /home/admin/.cargo/bin/rustup target add armv7-linux-androideabi \
# Cleanup
 && rm -rf /tmp/mozilla* \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

 ENV SHELL=/bin/bash \
     PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
     MOZBUILD_STATE_PATH=/opt/mozbuild
