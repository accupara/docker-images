# Copyright (c) 2020 Crave.io Inc. All rights reserved
FROM accupara/lkbuild:amd64
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        libtool \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
