# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/lkbuild:amd64
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update \
 && sudo apt-get install -y \
        gcc-arm-linux-gnueabi
