# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM centos:8
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

COPY sshd_config limits.conf github_git-lfs.repo /tmp/

# Install the minimum tools
RUN set -x \
# Add epel 8 first
 && yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
# ... then start installing packages
 && yum update -y \
 && yum install -y \
        autoconf \
        automake \
        binutils \
        emacs \
        gcc gcc-c++ \
        gettext \
        git \
# This package isn't available in Centos 8. This means rustc caching won't be recognizable by crave's automated script
        #hardening-check \
        jq \
        libevent-devel \
        make \
        ncurses-devel \
        openssh-server \
        redhat-lsb \
        rpm-build \
        rsync \
        subversion \
        sudo \
        vim \
        wget \
# Add the github-lfs repo so that we have the latest git client
 && sudo mv /tmp/github_git-lfs.repo /etc/yum.repos.d/ \
# Install the git-lfs package by default
 && yum install -y git-lfs \
# Download and install the latest tmux
 && export TMUX_VERSION=3.2 \
 && cd /tmp && wget https://github.com/tmux/tmux/releases/download/3.2/tmux-${TMUX_VERSION}.tar.gz \
 && tar -xf tmux-${TMUX_VERSION}.tar.gz && cd tmux-${TMUX_VERSION} \
 && LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local \
 && make -j `nproc` \
 && sudo make install \
 && cd .. && rm -rf tmux-${TMUX_VERSION}* \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add admin user and add it to sudoers
 && cat /etc/sudoers | sed '/Defaults.*requiretty/,+1 d' > /sudoers ; mv /sudoers /etc/sudoers \
 && useradd -u 1000 -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -aG wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
# Pre-configure the ssh server
 && mkdir -p /var/run/sshd \
 && ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/sshd \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/login \
 && mv /tmp/sshd_config /etc/ssh/ \
 && chmod 0600 /etc/ssh/* \
 && mv /tmp/limits.conf /etc/security/

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /home/admin

RUN chown -R admin:admin /home/admin \
# Helpful aliases
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
# Let the vimrc have sane defaults
 && echo ":color desert" >> /home/admin/.vimrc \
 && echo "set softtabstop=4 shiftwidth=4 tabstop=4 expandtab" >> /home/admin/.vimrc \
 && echo "set number" >> /home/admin/.vimrc \
# User ssh directory
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys

EXPOSE 22
CMD /bin/bash
