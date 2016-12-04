# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM centos:7
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

# Install the minimum tools
RUN yum install -y \
        autoconf \
        automake \
        binutils \
        gcc gcc-c++ \
        gettext \
        git \
        make \
        rpm-build \
        subversion \
        sudo \
        vim \
        wget

RUN cat /etc/sudoers | sed '/Defaults.*requiretty/,+1 d' > /sudoers ; mv /sudoers /etc/sudoers

RUN useradd -u 1000 -ms /bin/bash admin
RUN echo "admin:admin" | chpasswd
RUN usermod -aG wheel admin
RUN echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER admin
ENV HOME /home/admin
WORKDIR /home/admin

RUN chown -R admin:admin /home/admin
RUN echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc

CMD /bin/bash
