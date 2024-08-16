# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM alpine:3

ENV LANG en_US.utf8 \
    GIT_TERMINAL_PROMPT=0

RUN set -x \
 && apk update \
 && apk add --virtual \
    bash \
    bash-completion \
    binutils \
    build-base \
    #build-dependencies \
    ca-certificates \
    cmake \
    coreutils \
    curl \
    findutils \
    g++ \
    gcc \
    gcompat \
    git \
    grep \
    less \
    make \
    openssl \
    openssh-server \
    pciutils \
    pigz \
    rsync \
    shadow \
    subversion \
    sudo \
    tar \
    usbutils \
    util-linux \
    vim \
    wget \
    xz \
    zlib-dev \
# Add default admin user
 && addgroup -g 1000 -S admin \
 && adduser -u 1000 -D -s /bin/bash admin -G admin \
 && usermod --password admin admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && sed -i "/^export PS1=/c\export PS1='\\\\[\\\\033[01;32m\\\\]\\\\u@\\\\h\\\\[\\\\033[00m\\\\]:\\\\[\\\\033[01;34m\\\\]\\\\w\\\\[\\\\033[00m\\\\]\\\\\\$ '" /etc/profile \
 && mkdir -p /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config

# Fix for not having sshd host keys.
RUN /usr/bin/ssh-keygen -A

USER admin
ENV HOME=/home/admin \
    USER=admin TERM=xterm \
    GIT_TERMINAL_PROMPT=0
WORKDIR /home/admin
CMD ["/bin/bash"]

RUN set -x \
 && echo "export PS1='\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\\$ '" >> /home/admin/.bashrc \
 && echo ". /usr/share/bash-completion/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys

EXPOSE 22
