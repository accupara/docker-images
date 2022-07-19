# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        guile-3.0-dev \
        texinfo \
# Clean up image
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
