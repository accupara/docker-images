# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/emsdk:latest

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        libsdl2-mixer-dev \
# Cleanup apt cache
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
