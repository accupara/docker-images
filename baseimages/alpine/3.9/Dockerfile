# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM alpine:3.9
MAINTAINER Crave.io Inc. "contact@crave.io"

ENV LANG en_US.utf8

RUN apk update \
    && apk add --virtual build-dependencies \
        ca-certificates \
        openssl \
        openssh-server \
        tar \
        xz \
        pigz \
        build-base \
        gcc \
        g++ \
        zlib-dev \
        make \
        cmake \
        autoconf \
        wget \
        git \
        subversion \
        curl \
        less \
        bash \
        bash-completion \
        util-linux \
        pciutils \
        usbutils \
        coreutils \
        binutils \
        findutils \
        grep \
        shadow \
        rsync \
        sudo \
        vim

# Add glibc from custom repo
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk \
    && apk add glibc-2.29-r0.apk \
    && rm glibc-2.29-r0.apk

RUN addgroup -g 1000 -S admin \
    && adduser -u 1000 -D -s /bin/bash admin -G admin \
    && usermod --password admin admin \
    && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && sed -i "/^export PS1=/c\export PS1='\\\\[\\\\033[01;32m\\\\]\\\\u@\\\\h\\\\[\\\\033[00m\\\\]:\\\\[\\\\033[01;34m\\\\]\\\\w\\\\[\\\\033[00m\\\\]\\\\\\$ '" /etc/profile \
    && mkdir -p /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config

# Fix for not having sshd host keys.
RUN /usr/bin/ssh-keygen -A

USER admin
ENV HOME=/home/admin USER=admin TERM=xterm
WORKDIR /home/admin
CMD /bin/bash

RUN echo "export PS1='\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\\$ '" >> /home/admin/.bashrc \
    && echo ". /usr/share/bash-completion/bash_completion" >> /home/admin/.bashrc \
    && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
    && mkdir /home/admin/.ssh \
    && chmod 700 /home/admin/.ssh \
    && touch /home/admin/.ssh/authorized_keys

EXPOSE 22
