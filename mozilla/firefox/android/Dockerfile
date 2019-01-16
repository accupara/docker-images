# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
# From the deps specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
FROM accupara/firefox:desktop
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN cd /tmp/ \
 && export MOZBUILD_STATE_PATH=/opt/mozbuild \
 && echo 4 | python bootstrap.py --no-interactive \
 && /home/admin/.cargo/bin/rustup target add armv7-linux-androideabi \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

 ENV SHELL=/bin/bash \
     PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
     MOZBUILD_STATE_PATH=/opt/mozbuild
