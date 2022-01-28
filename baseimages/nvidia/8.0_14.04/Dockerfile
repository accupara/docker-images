# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM nvidia/cuda:8.0-devel-ubuntu14.04

COPY sshd_config /tmp/

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
# 14.04 key is too old. rely on the http transport to compensate
 && sed -i 's|https|http|g' /etc/apt/sources.list.d/cuda.list \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        curl \
        debhelper \
        dh-make \
        git \
        jq \
        locales \
        lsb-release \
        openssh-server \
        rsync \
        subversion \
        sudo \
        vim-nox \
        wget \
# Make sure to install git-lfs
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && apt-get install -y git-lfs \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -q -O /etc/crave/create_build_tools_json.sh https://github.com/accupara/docker-images/blob/master/baseimages/shared/create_build_tools_json.sh?raw=true \
 && chmod +x /etc/crave/create_build_tools_json.sh \
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

EXPOSE 22
