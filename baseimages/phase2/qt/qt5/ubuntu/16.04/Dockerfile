# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
        libphonon-dev \
        libqt5webkit5-dev \
        libqt5xmlpatterns5-dev \
        libssl-dev \
        qt5-default \
        qtmultimedia5-dev \
# Clean up image
 && echo ". /etc/bash_completion" | sudo tee -a /root/.bashrc \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
