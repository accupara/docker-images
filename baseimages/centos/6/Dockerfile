# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM centos:6
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY sshd_config limits.conf github_git-lfs.repo create_build_tools_json.sh /tmp/

RUN set -x \
# Centos 6 is EOL starting Nov 20, 2020. It's time to use the vault instead of the regular mirrors
# 1. Comment out all mirrorlist lines
# 2. Uncomment baseurl and replace "mirror" with "vault"
 && find /etc/yum.repos.d/ -type f | \
        while read line ; do \
            sed -s 's/^mirrorlist=/#mirrorlist=/g' $line | \
            sed -s 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' >$line-temp ; \
            cp -f $line $line.orig ; \
            mv -f $line-temp $line ; \
        done \
# With the modifications above, this update shouldn't fail
 && yum update -y \
# Install the minimum tools
 && yum install -y \
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
        rsync \
        subversion \
        sudo \
        vim \
        wget \
# Add the github-lfs repo so that we have the latest git client
 && sudo mv /tmp/github_git-lfs.repo /etc/yum.repos.d/ \
# Add the EPEL 6 repo.... from the archives instead of the live rpm. Centos 6 is EOL'd!
# && yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
 && yum install -y https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/epel-release-6-8.noarch.rpm \
 && yum update -y \
# Install git-lfs and jq separately
 && yum install -y \
    git-lfs \
    jq \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && mv /tmp/create_build_tools_json.sh /etc/crave \
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
