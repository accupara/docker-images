# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM centos:6
MAINTAINER Accupara Inc. "contact@accupara.com"

COPY sshd_config limits.conf /tmp/

# Install the minimum tools
RUN yum install -y \
        autoconf \
        automake \
        binutils \
        gcc gcc-c++ \
        gettext \
        git \
        make \
        openssh-server \
        redhat-lsb \
        rpm-build \
        subversion \
        sudo \
        vim \
        wget \
 && cat /etc/sudoers | sed '/Defaults.*requiretty/,+1 d' > /sudoers ; mv /sudoers /etc/sudoers \
 && useradd -u 1000 -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -aG wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/run/sshd \
 && ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/sshd \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/login \
 && mv /tmp/sshd_config /etc/ssh/ \
 && mv /tmp/limits.conf /etc/security/

USER admin
ENV HOME=/home/admin USER=admin TERM=xterm
WORKDIR /home/admin

RUN chown -R admin:admin /home/admin \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys

EXPOSE 22
CMD /bin/bash
