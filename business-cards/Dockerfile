# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
 && sudo apt-get update \
# Install tex, xetex
# Install font-awesome
# Install Fira Sans Font
 && sudo apt-get install -y \
    fonts-firacode \
    fonts-font-awesome \
    inkscape \
    texlive-full \
    texlive-xetex \
    unzip \
    wget \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
