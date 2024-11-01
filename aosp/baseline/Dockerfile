# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/golang:1.22-bullseye AS atools

ENV ANDROID_TOOLS_VER=35.0.1

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
    cmake \
    golang-goprotobuf-dev \
    libbrotli-dev \
    libgtest-dev \
    liblz4-dev \
    libpcre2-dev \
    libprotobuf-dev \
    libunwind-dev \
    libusb-1.0-0-dev \
    libzstd-dev \
# Better android-tools: https://github.com/nmeum/android-tools#installation
 && cd /tmp/ \
 && wget -q https://github.com/nmeum/android-tools/releases/download/${ANDROID_TOOLS_VER}/android-tools-${ANDROID_TOOLS_VER}.tar.xz -O android-tools.tar.xz \
 && tar -xf android-tools.tar.xz \
 && mv android-tools-${ANDROID_TOOLS_VER} android-tools \
 && cd android-tools \
 && mkdir build && cd build \
 && cmake .. \
 && make -j `nproc` \
 && sudo make install

FROM accupara/debian:12

# https://github.com/mesonbuild/meson/releases
ENV YQ_VER=4.40.3 \
    MESON_VER=1.4.0 \
    REPO_NO_INTERACTIVE=1

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
    bison \
    brotli \
    build-essential \
    curl \
    elfutils \
    flex \
    gnupg \
    gperf \
    imagemagick \
    libfreetype6 \
    libncurses5-dev \
    libncurses5 \
    libgl1-mesa-dev \
    libx11-dev \
    libxml2-utils \
    meson \
    ninja-build \
    openjdk-11-jdk \
    pkg-config \
    unzip \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
# For schedtool (sorted by name)
 && sudo eatmydata apt-get install -y \
    autoconf \
    automake \
    bash \
    bc \
    binutils \
    bison \
    build-essential \
    bzip2 \
    clang \
    cmake \
    cpio \
    curl \
    dialog \
    dos2unix \
    expect \
    flex \
    g++ \
    gawk \
    gcc \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabi \
    gcc-arm-linux-gnueabihf \
    git \
    gperf \
    jq \
    liblz4-tool \
    libncurses5-dev \
    libsdl1.2-dev \
    libssl-dev \
    libstdc++6 \
    libxml2 \
    libxml2-utils \
    lld \
    lldb \
    llvm \
    lzop \
    make \
    neofetch \
    openssl \
    perl \
    pngcrush \
    python2 \
    python3 \
    python3-mako \
    schedtool \
    sed \
    squashfs-tools \
    tar \
    unzip \
    wget \
    xsltproc \
    zip \
    zlib1g-dev \
    zstd \
    iputils-arping \
    iputils-clockdiff \
    iputils-ping \
    iputils-tracepath \
    inetutils-tools \
    xmlstarlet \
# Requested by users
 && sudo eatmydata apt-get install -y \
    nano \
    ripgrep \
    tree \
# For the dumper
 && sudo eatmydata apt-get install -y \
    python3-venv \
    virtualenv \
# Create a directory for aosp
 && sudo mkdir -p /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
# Remove python 2 completely
 && sudo eatmydata apt-get purge -y python python2.7 \
 && sudo eatmydata apt-get -y autoremove \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
# Make sure that the default version of python is 3
 && if [ $(python --version | grep -c 'Python 3') -eq "0" ] ; then exit 1 ; fi \
# Create a download location to cleanup later
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
# Add the yq tool from the releases at https://github.com/mikefarah/yq
 && wget -q -O yq https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_amd64 \
 && chmod +x yq \
 && sudo mv yq /usr/bin/ \
# This is required for build Mesa3D for aosp builds that wants or needs to use foss drivers
 && sudo sed -i '/^#\sdeb-src /s/^#//' "/etc/apt/sources.list" \
 && sudo eatmydata apt update \
 && sudo eatmydata apt build-dep mesa -y \
 && sudo eatmydata apt remove meson -y \
# Add the latest version of the meson build system
 && wget -q https://github.com/mesonbuild/meson/releases/download/${MESON_VER}/meson-${MESON_VER}.tar.gz \
 && tar -xf meson-${MESON_VER}.tar.gz \
 && cd meson-${MESON_VER} \
 && sudo python3 setup.py build \
 && sudo python3 setup.py install \
# Install Rclone
 && curl https://rclone.org/install.sh | sudo bash -s beta \
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
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/resynctest.sh -O /opt/crave/resynctest.sh \
 && chmod +x /opt/crave/resynctest.sh \
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
# Just disable ccache by replacing the binary with a script that doesn't do anything
 && sudo mkdir -p /opt/crave/ \
 && sudo chown admin:admin /opt/crave/ \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/not_ccache.sh -O /opt/crave/not_ccache.sh \
 && chmod +x /opt/crave/not_ccache.sh \
 #&& sudo ln -s /opt/crave/not_ccache.sh /usr/bin/ccache \
# Save the crave_sign.sh script into the appropriate location
 && sudo chown -R admin:admin /opt/crave \
 && wget -q https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/crave_sign.sh -O /opt/crave/crave_sign.sh \
 && chmod +x /opt/crave/crave_sign.sh \
# Final cleanups
 && cd /tmp \
 && sudo find dl -delete \
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

COPY --from=atools /tmp/android-tools/install/bin/ /usr/bin/
COPY --from=atools /tmp/android-tools/vendor/mkbootimg/mkbootimg.py /usr/local/share/android-tools/mkbootimg/
