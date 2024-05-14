# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04

ENV YQ_VER=4.40.3

RUN set -x \
 && sudo dpkg --add-architecture i386 \
 && sudo apt-get update \
 && sudo apt-get -y install \
    bc \
    bison \
    # brotli \
    build-essential \
    curl \
    flex \
    g++-multilib \
    gcc-multilib \
    gnupg \
    gperf \
    imagemagick \
    lib32ncurses5-dev \
    lib32readline-dev \
    lib32z1-dev \
    libc6:i386 \
    libelf-dev \
    liblz4-tool \
    libncurses5:i386 \
    libncurses5-dev \
    libncurses5 \
    libfreetype6 \
    libgl1-mesa-dev \
    libsdl1.2-dev \
    libssl-dev \
    libstdc++6:i386 \
    libwxgtk2.8-dev \
    libx11-dev \
    libxml2 \
    libxml2-utils \
    lzop \
    m4 \
    openjdk-6-jdk \
    pngcrush \
    schedtool \
    squashfs-tools \
    unzip \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
# Add the yq tool from the releases at https://github.com/mikefarah/yq
 && wget -q -O yq https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_amd64 \
 && chmod +x yq \
 && sudo mv yq /usr/bin/ \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Save the resync.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/ \
 && sudo chown admin:admin /opt/crave/ \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/resync.sh -O /opt/crave/resync.sh \
 && chmod +x /opt/crave/resync.sh \
# Save the upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/github-actions \
 && sudo chown admin:admin /opt/crave/github-actions \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/upload.sh -O /opt/crave/github-actions/upload.sh \
 && chmod +x /opt/crave/github-actions/upload.sh \
 # Save the telegram upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/telegram \
 && sudo chown -R admin:admin /opt/crave \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/tgup.sh -O /opt/crave/telegram/upload.sh \
 && chmod +x /opt/crave/telegram/upload.sh \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0
