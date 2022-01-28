# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

COPY kb-config.exp /tmp/

RUN set -x \
# Download the FULL cuda sdk
 && cd /tmp/ \
 && wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin \
 && sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 \
 && wget -q http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb \
 && sudo dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb \
 && sudo apt-key add /var/cuda-repo-10-1-local-10.1.243-418.87.00/7fa2af80.pub \
 && sudo apt-get update \
# Install keyboard configuration so that cuda installation doesn't prompt for user input
 && sudo apt-get install -y expect && sudo expect /tmp/kb-config.exp \
 && sudo apt-get install -y \
        cuda \
 && rm cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb \
# Cleanup apt cache
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

 ENV PATH=/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
     LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64
