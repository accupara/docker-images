# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

ENV YQ_VER=4.40.3 \
    MESON_VER=1.4.0 \
    REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
    bison \
    brotli \
    build-essential \
    curl \
    flex \
    gnupg \
    gperf \
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
    pkg-config \
    libudev1 \
    zlib1g-dev \
    python3-pkg-resources \
    python3-ply \
    python3-pygments \
    python3-markupsafe \
    python3-setuptools \
    python3-pkg-resources \
    python3-distutils \
    python3-markupsafe \
    python3-lib2to3 \
    python3-yaml \
    python3-mako \
    libtool \
    make \
    libstd-rust-dev \
    libstd-rust-1.75 \
    libstdc++-11-dev \
    linux-libc-dev \
    libncurses-dev \
    libpthread-stubs0-dev \
    libsigsegv2 \
    libyaml-0-2 \
    lto-disabled-list \
    llvm-spirv-15 \
    m4 \
    patch \
    libllvmspirvlib15 \
    rustc \
    libzstd1 \
    libzstd-dev \
    perl-modules-5.34 \
    libperl5.34 \
    libset-scalar-perl \
    libvulkan \
    libvulkan-dev \
    spirv-tools \
    libglvnd-core-dev \
    gettext-base \
    glslang-tools \
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
# Add the latest version of the meson build system
 && wget -q https://github.com/mesonbuild/meson/releases/download/${MESON_VER}/meson-${MESON_VER}.tar.gz \
 && tar -xf meson-${MESON_VER}.tar.gz \
 && cd meson-${MESON_VER} \
 && sudo python3 setup.py build \
 && sudo python3 setup.py install \
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
 && cd /tmp \
 && sudo find dl -delete \
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
