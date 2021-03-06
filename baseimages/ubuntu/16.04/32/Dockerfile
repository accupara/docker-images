# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM i386/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY sshd_config /tmp/

# Install the minimum tools
RUN apt-get update \
    && echo "console-setup   console-setup/codeset47 select  # Latin1 and Latin5 - western Europe and Turkic languages" | debconf-set-selections \
    && echo "console-setup   console-setup/fontface47        select  Fixed" | debconf-set-selections \
    && echo "console-setup   console-setup/fontsize-text47   select  16" | debconf-set-selections \
    && echo "console-setup   console-setup/charmap47 select  UTF-8" | debconf-set-selections \
    && echo "keyboard-configuration  console-setup/detect    detect-keyboard" | debconf-set-selections \
    && echo "keyboard-configuration  console-setup/detected  note" | debconf-set-selections \
    && echo "console-setup   console-setup/codesetcode       string  Lat15" | debconf-set-selections \
    && echo "keyboard-configuration  console-setup/ask_detect        boolean false" | debconf-set-selections \
    && echo "console-setup   console-setup/store_defaults_in_debconf_db      boolean true" | debconf-set-selections \
    && echo "console-setup   console-setup/fontsize-fb47     select  16" | debconf-set-selections \
    && echo "console-setup   console-setup/fontsize  string  16" | debconf-set-selections \
    && echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
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
        git \
        jq \
        locales \
        lsb-release \
        openssh-server \
        rsync \
        subversion \
        sudo \
        tmux \
        vim-nox \
# Make sure to install git-lfs
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && apt-get install -y git-lfs \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
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
