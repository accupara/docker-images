# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
        libphonon4qt5-dev \
        libqt5webkit5-dev \
        libqt5xmlpatterns5-dev \
        libssl-dev \
        qtmultimedia5-dev \
# Clean up image
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
