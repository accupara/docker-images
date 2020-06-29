# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/yocto:ubuntu_1804
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get -y install \
    curl \
    autoconf \
    automake \
    gettext \
    libboost-dev \
    libz-dev \
    g++ \
    gawk \
    wget \
    git-core \
    diffstat \
    unzip \
    texinfo \
    gcc-multilib \
    build-essential \
    chrpath \
    socat \
    cpio \ 
    python \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \ 
    libegl1-mesa \
    libsdl1.2-dev \
    pylint3 \
    xterm \
    locales \
    g++-multilib \
    subversion \
    screen \
    tmux \
    iputils-ping \
    iproute2 \
    fluxbox \
    tightvncserver
RUN sudo locale-gen en_US.UTF-8 \
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mkdir /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 \
# This is required for agl compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
 && git config --global color.ui false
USER root
ADD https://raw.githubusercontent.com/crops/extsdk-container/master/restrict_useradd.sh  \
        https://raw.githubusercontent.com/crops/extsdk-container/master/restrict_groupadd.sh \
        https://raw.githubusercontent.com/crops/extsdk-container/master/usersetup.py \
        /usr/bin/
COPY poky-entry.py poky-launch.sh /usr/bin/
COPY sudoers.admin /etc/
RUN cp -af /etc/skel/ /etc/vncskel/ && \
    echo "export DISPLAY=1" >>/etc/vncskel/.bashrc && \
    mkdir  /etc/vncskel/.vnc && \
    echo "" | vncpasswd -f > /etc/vncskel/.vnc/passwd && \
    chmod 0600 /etc/vncskel/.vnc/passwd
RUN userdel -r admin && \
    groupadd -g 70 admin && \
    useradd -N -m -u 70 -g 70 admin && \
    chmod 755 /usr/bin/usersetup.py \
        /usr/bin/poky-entry.py \
        /usr/bin/poky-launch.sh \
        /usr/bin/restrict_groupadd.sh \
        /usr/bin/restrict_useradd.sh && \
    echo "#include /etc/sudoers.admin" >> /etc/sudoers

USER admin

CMD /bin/bash
ENV LANG=en_US.UTF-8
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/bin/poky-entry.py"]
