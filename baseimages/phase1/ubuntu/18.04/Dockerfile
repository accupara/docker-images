# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

# Compile remake and rsync on the fly and keep it ready for the next stage
# Chicken or egg : Which came first?
FROM accupara/ubuntu:18.04 as remake
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        guile-2.2-dev \
        texinfo \
 && git clone https://github.com/rocky/remake.git \
 && cd remake \
 && ./autogen.sh \
 && ./configure \
 && make -j `nproc` \
 && mv ./make /tmp/

# The binary generated from this step works in centos 6 and 7, and ubuntu 14.04,16.04,18.04,20.04. It does not work in 22.04
FROM accupara/ubuntu:18.04 as rsync
RUN set -x \
 && sudo apt-get update -y \
 && sudo apt-get install -y \
    golang-github-pierrec-xxhash-dev \
    libpopt-dev \
    libssl-dev \
    liblz4-dev \
    zlib1g-dev \
 && export RSYNC_VER=3.2.7 \
 && curl https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VER}.tar.gz -o rsync-${RSYNC_VER}.tar.gz \
 && tar -xf rsync-${RSYNC_VER}.tar.gz \
 && cd rsync-${RSYNC_VER} \
 && ./configure --prefix=/tmp/rsync --disable-xxhash --disable-zstd \
# This command fails because of the stupid way the linker needs the correct order, but the Makefile isn't written in a way to support that.
 && make -j `nproc` \
 && make install \
 && strip /tmp/rsync/bin/rsync

################## The real container starts here ##################
FROM ubuntu:18.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

COPY sshd_config /tmp/

# https://mirrors.edge.kernel.org/pub/software/scm/git/
# https://gradle.org/releases/
# https://github.com/ninja-build/ninja/releases
ENV GIT_VER=2.45.1 \
    GIT_LFS_VER=3.5.1 \
    GRADLE_VER=8.7 \
    NINJA_VER=v1.12.1

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && set -x \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
      bash-completion \
      binutils \
      build-essential \
      curl \
      debhelper \
      devscripts \
      dh-make \
      eatmydata \
      emacs \
      guile-2.2 \
      libpopt0 \
      libxxhash0 \
      jq \
      locales \
      lsb-release \
      multitail \
      ninja-build \
      openssh-server \
      psmisc \
      # install rsync because it allows the updated rsync to work correctly
      rsync \
      subversion \
      sudo \
      tmux \
      vim-nox \
      wget \
      # for lndir
      xutils-dev \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
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
 && wget -q https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VER}/git-lfs-linux-$arch-v${GIT_LFS_VER}.tar.gz \
 && tar -xf git-lfs-linux-$arch-v${GIT_LFS_VER}.tar.gz \
 && cd git-lfs-${GIT_LFS_VER} \
 && ./install.sh \
# Install the latest version of gradle
 && cd /tmp/dl \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
# Install the latest version of repo, as described in https://gerrit.googlesource.com/git-repo
 && cd /tmp/dl \
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# Add the latest version of the ninja-build
 && cd /tmp/dl \
 && wget https://github.com/ninja-build/ninja/releases/download/${NINJA_VER}/ninja-linux.zip \
 && unzip ninja-linux.zip \
 && chmod +x ninja \
 && sudo mv ninja /usr/bin/ \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add the crave binary into the base image
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && sudo mv crave /usr/local/bin/ \
# Add admin user and add it to sudoers
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
# Configure sshd
 && mkdir -p /var/run/sshd \
 && mv /tmp/sshd_config /etc/ssh/sshd_config \
# Clean up image
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && cd /tmp \
 && find /tmp/dl -delete \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /home/admin
CMD /bin/bash

RUN set -x \
# bashrc, ssh directory, completions, etc.
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/* \
# locale setup
 && sudo locale-gen en_US.UTF-8 \
 && sudo update-locale LANG=en_US.UTF-8 \
# Export env vars
 && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc

# Copy these at the very end
COPY --from=remake /tmp/make /usr/bin/remake
COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
