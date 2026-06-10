# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM fedora:43
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

ENV GIT_VER=2.50.1

# Install the minimum set of tools
RUN set -x \
 && dnf update -y \
 && dnf -y install \
    bash-completion \
    file \
    git \
    gcc-c++ \
    jq \
    make \
    openssh-server \
    subversion \
    sudo \
    vim-enhanced \
    wget \
# Install compilation tools
 && dnf -y install @development-tools \
 && dnf -y group install "C Development Tools and Libraries" \
 && echo ". /etc/bash_completion" >> /root/.bashrc \
# Create a temporary workspace
 && mkdir -p /tmp/dl \
# Install the latest git
 && dnf -y install \ 
    expat-devel \
    gnutls-devel \
    libcurl-devel \
    openssl-devel \
    zlib-devel \
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all -j `nproc` \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
# Non root user
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -aG wheel admin \
# Add to sudoers the standard way so it overrides wheel defaults
 && mkdir -p /etc/sudoers.d \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/admin \
 && chmod 0440 /etc/sudoers.d/admin \
 && chmod 0640 /etc/shadow \
 && mkdir -p /var/run/sshd \
# Cleanup at the end
 && cd /tmp \
 && rm -rf /tmp/dl

COPY sshd_config /etc/ssh/sshd_config

USER admin
ENV HOME=/home/admin \
    USER=admin \
    GIT_TERMINAL_PROMPT=0
WORKDIR /home/admin
CMD ["/bin/bash"]

RUN set -x \
 && ls -l /etc/shadow \
 && sudo chown -R admin:admin /home/admin \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/*

EXPOSE 22
