# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/lkbuild:amd64
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update \
 && sudo apt-get install -y \
        gcc-arm-linux-gnueabi
