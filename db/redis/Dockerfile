# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

SHELL ["/bin/bash", "-c"]
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    pkg-config \
    tcl \
# Cleanup
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
