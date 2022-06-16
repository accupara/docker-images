# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/debian:8 as remake
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        autopoint \
        guile-2.0-dev \
        rsync \
        texinfo \
# Fetch gettext sources and compile them
 && wget -q --no-check-certificate https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz \
 && tar -xf gettext-0.21.tar.gz \
 && cd gettext-0.21 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Get the remake sources for 4.3 and compile them
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh --enable-maintainer-mode \
 && make -j `nproc` \
 && mv ./make /tmp/

################## The real container starts here ##################
FROM debian:8
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

COPY sshd_config /tmp/
COPY --from=remake /tmp/make /usr/bin/remake

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        debhelper \
        devscripts \
        dh-make \
        guile-2.0 \
        jq \
        locales \
        lsb-release \
        ninja-build \
        subversion \
        sudo \
        vim-nox \
        wget \
# Install the latest git
 && export GIT_VER=2.36.1 \
 && cd /tmp && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; sudo rm -rf v${GIT_VER}.tar.gz git-${GIT_VER} \
# Install the latest version of gradle
 && cd /tmp \
 && export GRADLE_VER=7.4.2 \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && sudo mv gradle-${GRADLE_VER} /usr/lib/ \
 && sudo ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && rm gradle-${GRADLE_VER}-bin.zip \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add admin user and add it to sudoers
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
# Configure sshd
 && mkdir -p /var/run/sshd \
 && mv /tmp/sshd_config /etc/ssh/sshd_config \
# Clean up image
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /home/admin
CMD /bin/bash

RUN set -x \
# bashrc, ssh directory, completions, etc.
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/* \
# locale setup
 && sudo sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
 && sudo locale-gen \
# Export env vars
 && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc

EXPOSE 22
