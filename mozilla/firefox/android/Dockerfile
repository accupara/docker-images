# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
# From the deps specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
FROM accupara/firefox:desktop
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN cd /tmp/ \
 && echo 4 | python bootstrap.py --no-interactive \
 && /home/admin/.cargo/bin/rustup target add armv7-linux-androideabi

 ENV SHELL=/bin/bash \
     PATH=/home/admin/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
     MOZBUILD_STATE_PATH=/opt/mozbuild
