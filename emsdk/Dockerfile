# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM emscripten/emsdk

ENV YQ_VER=4.40.3 \
    REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0 \
    GIT_VER=2.45.2 \
    GIT_LFS_VER=3.5.1 \
    GRADLE_VER=8.4

RUN set -x \
 #&& sudo dpkg --add-architecture i386 \
 && sudo apt-get update \
 && sudo apt-get -y install \
        binutils \
        build-essential \
        ca-certificates \
        file \
        git \
        python3 \
        python3-pip \
# Install the latest git
 && eatmydata apt-get install -y \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all -j `nproc` \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
# Make sure to install git-lfs the direct way. no mucking around with apt
 && cd /tmp/dl \
 && arch="$(uname -m)"; \
       case "$arch" in \
              x86_64)  lfsArch='amd64' ;; \
              aarch64) lfsArch='arm64' ;; \
              ppc64le) lfsArch='ppc64le' ;; \
              s390x) lfsArch='s390x' ;; \
              *) echo >&2 "error: unsupported architecture ($arch)"; exit 1 ;;\
       esac \
 && wget -q https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VER}/git-lfs-linux-$lfsArch-v${GIT_LFS_VER}.tar.gz \
 && tar -xf git-lfs-linux-$lfsArch-v${GIT_LFS_VER}.tar.gz \
 && cd git-lfs-${GIT_LFS_VER} \
 && ./install.sh \
# Install the latest version of gradle
 && cd /tmp \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && eatmydata -- unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && rm gradle-${GRADLE_VER}-bin.zip \
# Add the yq tool from the releases at https://github.com/mikefarah/yq
 && wget -q -O yq https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_amd64 \
 && chmod +x yq \
 && sudo mv yq /usr/bin/ \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
