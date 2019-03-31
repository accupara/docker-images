# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM i386/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

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
        debhelper \
        dh-make \
        git \
        lsb-release \
        openssh-server \
        rsync \
        subversion \
        sudo \
        vim-nox \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/run/sshd

USER admin
ENV HOME=/home/admin USER=admin TERM=xterm
WORKDIR /home/admin
CMD /bin/bash

RUN sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/*

EXPOSE 22
