# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM openjdk:15-jdk
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY sshd_config limits.conf /tmp/

# Install the minimum tools
RUN set -x \
 && yum update -y \
 && yum install -y \
        ant \
        bash-completion \
        binutils \
        curl-devel \
        expat-devel \
        gettext-devel \
        gcc \
        git \
        openssl-devel \
        openssh-server \
        perl-ExtUtils-MakeMaker \
        redhat-lsb \
        rpm-build \
        sudo \
        vim \
        wget \
        zlib-devel \
# Install git v2 on Oracle Linux
 && yum remove git -y \
 && cd /usr/src \
 && wget https://www.kernel.org/pub/software/scm/git/git-2.26.2.tar.gz \
 && tar xvf git-2.26.2.tar.gz \
 && cd git-2.26.2 \
 && make -j4 prefix=/usr/local/git all \
 && make -j4 prefix=/usr/local/git install \
 && echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc \
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
 && mv /tmp/limits.conf /etc/security/ \
# Let's get the latest git client
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash

USER admin
ENV HOME=/home/admin USER=admin TERM=xterm
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
