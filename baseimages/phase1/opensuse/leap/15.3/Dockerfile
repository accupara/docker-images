# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM opensuse/leap:15.3
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# https://mirrors.edge.kernel.org/pub/software/scm/git/
# https://gradle.org/releases/
# https://github.com/ninja-build/ninja/releases
ENV GIT_VER=2.45.2 \
    GIT_LFS_VER=3.5.1 \
    GRADLE_VER=8.7 \
    NINJA_VER=v1.12.1

# Install the minimum set of tools
RUN set -x \
 && zypper update -y \
 && zypper install -y \
      bash-completion \
      curl \
      eatmydata \
      file \
      git \
      gcc-c++ \
      jq \
      lsb-release \
      make \
      openssh-server \
      subversion \
      sudo \
      unzip \
      vim-enhanced \
      wget \
# Install compilation tools
 && eatmydata zypper install -y -t pattern devel_basis \
# Install the latest git
 && eatmydata zypper install -y \
      libcurl-devel \
      libexpat-devel \
      libgnutls-devel \
      libopenssl-devel \
      zlib-devel \
 && mkdir -p /tmp/dl \
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
 && cd /tmp/dl \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
# Install the latest version of repo, as described in https://gerrit.googlesource.com/git-repo
 && wget -O /tmp/repo https://storage.googleapis.com/git-repo-downloads/repo \
 && mv /tmp/repo /usr/bin/repo \
 && chmod +x /usr/bin/repo \
# Add the latest version of the ninja-build
 && cd /tmp/dl \
 && wget https://github.com/ninja-build/ninja/releases/download/${NINJA_VER}/ninja-linux.zip \
 && unzip ninja-linux.zip \
 && chmod +x ninja \
 && mv ninja /usr/bin/ \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add the crave binary into the base image
 && (curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- && mv crave /usr/local/bin/) || true \
# Non-root user
 && useradd -ms /bin/bash admin \
 && groupadd admin \
 && usermod -a -G admin admin \
# Argh why does OpenSuse have to be so hard?
 && echo "admin:abc1!2@3#" | chpasswd \
# Add to sudoers
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/run/sshd \
 && echo ". /etc/bash_completion" >> /root/.bashrc

COPY sshd_config /etc/ssh/sshd_config

USER admin
ENV HOME=/home/admin USER=admin
WORKDIR /home/admin
CMD ["/bin/bash"]

RUN sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >>/home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >>/home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/*

EXPOSE 22
