# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved

# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/ubuntu:22.04 as remake
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        guile-3.0-dev \
        texinfo \
 && git clone https://github.com/rocky/remake.git \
 && cd remake \
 && ./autogen.sh \
 && ./configure \
 && make -j `nproc` \
 && mv ./make /tmp/

################## The real container starts here ##################
FROM ubuntu:22.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

COPY sshd_config /tmp/

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
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
       git-lfs \
       guile-3.0 \
       jq \
       libpopt0 \
       libxxhash0 \
       locales \
       lsb-release \
       multitail \
       ninja-build \
       openssh-server \
       psmisc \
       rsync \
       subversion \
       sudo \
       tmux \
       vim-nox \
       wget \
# Compile and install the latest git
 && eatmydata -- apt-get install -y \
       libcurl4-gnutls-dev \
       libexpat1-dev \
       libssl-dev \
       zlib1g-dev \
 && export GIT_VER=2.39.3 \
 && cd /tmp && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && eatmydata -- tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && eatmydata -- make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && eatmydata -- make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; eatmydata -- rm -rf v${GIT_VER}.tar.gz git-${GIT_VER}* \
# Install the latest version of gradle
 && cd /tmp \
 && export GRADLE_VER=7.5.1 \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && eatmydata -- unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && rm gradle-${GRADLE_VER}-bin.zip \
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
 && echo ". /etc/bash_completion" >>/root/.bashrc \
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

COPY --from=remake /tmp/make /usr/bin/remake
#COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
