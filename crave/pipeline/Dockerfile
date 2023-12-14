# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM ubuntu:22.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

RUN set -x \
# Defaults to run crave
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y eatmydata \
 && eatmydata apt-get install -y \
    git \
    openssh-client \
    rsync \
# Clean up image
 && eatmydata apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

COPY bin/crave /usr/local/bin
