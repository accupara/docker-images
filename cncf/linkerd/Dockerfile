# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/openjdk:8

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
