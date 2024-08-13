# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/opensuse:leap-5.13

RUN set -x \
 && sudo zypper addrepo https://download.opensuse.org/repositories/openSUSE:Leap:15.3:Update/standard/openSUSE:Leap:15.3:Update.repo \
 && sudo zypper refresh \
 && zypper install -y \
        bc \
        bison \
        dos2unix \
        flex \
        gcc \
        glibc-32bit \
        gzip \
        iputils \
        libelf-devel \
        make \
        python \
        python-xml \
        python3 \
        openssh-server \
        sudo \
        tar \
        wget \
        xz \
# Stop asking me about colors
 && git config --global color.ui false