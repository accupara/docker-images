# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM centos:7
MAINTAINER Accupara Inc. "contact@accupara.com"

# Install the minimum tools
RUN yum install -y \
        autoconf \
        automake \
        binutils \
        gcc gcc-c++ \
        gettext \
        git \
        redhat-lsb \
        make \
        rpm-build \
        subversion \
        sudo \
        vim \
        wget \
 && cat /etc/sudoers | sed '/Defaults.*requiretty/,+1 d' > /sudoers ; mv /sudoers /etc/sudoers \
 && useradd -u 1000 -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -aG wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER admin
ENV HOME /home/admin
WORKDIR /home/admin

RUN chown -R admin:admin /home/admin \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc

CMD /bin/bash
