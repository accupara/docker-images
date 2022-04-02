# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/ubuntu:14.04 as remake
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        autopoint \
        guile-2.0-dev \
        texinfo \
# Fetch gettext sources and compile them
 && wget -q --no-check-certificate https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz \
 && tar -xf gettext-0.21.tar.gz \
 && cd gettext-0.21 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Get the remake sources for 4.3 and compile them
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh \
 && ./configure --enable-maintainer-mode \
 && make -j `nproc` \
 && mv ./make /tmp/

################## The real container starts here ################## 
FROM ubuntu:14.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"
COPY --from=remake /tmp/make /usr/bin/remake

# Install the minimum tools
RUN set -x \
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
        emacs \
        gettext \
        git \
        gradle \
        guile-2.0 \
        jq \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libssl-dev \
        locales \
        lsb-release \
        ninja-build \
        openssh-server \
        rsync \
        subversion \
        sudo \
        tmux \
        vim-nox \
        unzip \
# Make sure to install git-lfs
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && apt-get install -y git-lfs \
# Install the latest git
 && export GIT_VER=2.35.1 \
 && cd /tmp && wget -q https://github.com/git/git/archive/refs/tags/v${GIT_VER}.tar.gz \
 && tar -xf v${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; sudo rm -rf v${GIT_VER}.tar.gz git-${GIT_VER} \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Clean up image
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
# Bash completion and admin in sudoers
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config

USER admin
ENV HOME=/home/admin USER=admin TERM=xterm
WORKDIR /home/admin
CMD /bin/bash

RUN set -x \
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/*

EXPOSE 22
