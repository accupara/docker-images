# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
 && sudo apt-get update -y \
 && sudo apt-get install -y \
    python3-pip \
 && sudo python3 -m pip install \
    tensorflow \
# Clean up image
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
