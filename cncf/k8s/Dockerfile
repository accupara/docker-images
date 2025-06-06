# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM registry.k8s.io/build-image/kube-cross:v1.30.0-go1.22.2-bullseye.0
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
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

COPY sshd_config /etc/ssh/sshd_config

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm
WORKDIR /home/admin
CMD ["/bin/bash"]

RUN sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys

EXPOSE 22
