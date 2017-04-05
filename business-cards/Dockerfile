# Copyright (c) 2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.10

# Install tex, xetex
# Install font-awesome
# Install Fira Sans from Mozilla (as documented in https://stevescott.ca/2016-10-20-installing-the-fira-font-in-ubuntu.html)

RUN sudo apt-get update
RUN sudo apt-get install -y \
    fonts-font-awesome \
    inkscape \
    texlive-full \
    texlive-xetex \
    unzip \
    wget \
 && cd /tmp ; wget https://raw.githubusercontent.com/stevebscott/steves-bash-utils/master/install-fira.sh \
 && chmod +x /tmp/install-fira.sh && /tmp/install-fira.sh \
 && sudo rm -rf /tmp/master.zip* /tmp/Fira-* /tmp/install* \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*
