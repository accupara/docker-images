# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

# Install tex, xetex
# Install font-awesome
# Install Fira Sans from Mozilla (as documented in https://stevescott.ca/2016-10-20-installing-the-fira-font-in-ubuntu.html)

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    fonts-font-awesome \
    inkscape \
    texlive-full \
    texlive-xetex \
    unzip \
    wget \
 && cd /tmp ; wget -q https://raw.githubusercontent.com/stevebscott/steves-bash-utils/master/install-fira.sh \
 && chmod +x /tmp/install-fira.sh && /tmp/install-fira.sh \
 && sudo rm -rf /tmp/master.zip* /tmp/Fira-* /tmp/install* \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
