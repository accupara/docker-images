# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/centos:8 as remake
RUN set -x \
 && sudo yum update -y \
 && sudo dnf -y install dnf-plugins-core \
 && sudo dnf upgrade \
 && sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
 && sudo dnf config-manager --set-enabled powertools \
 && sudo yum install -y \
    gettext-devel \
    readline-devel \
    texinfo \
    texinfo-tex \
# Get the remake sources for 4.3 and compile them
 && cd /home/admin \
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh \
 && make -j `nproc` \
 && mv ./make /tmp/

################## The real container starts here ##################
FROM centos:8
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

COPY sshd_config limits.conf github_git-lfs.repo /tmp/
COPY --from=remake /tmp/make /usr/bin/remake

# Install the minimum tools
RUN set -x \
# Add epel 8 first
 && yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
# Enable the powertools package next (while installing ninja-build
 && dnf --enablerepo=powertools install -y ninja-build \
# ... then start installing packages
 && yum update -y \
 && yum install -y \
        autoconf \
        automake \
        binutils \
        emacs \
        gcc gcc-c++ \
        gettext \
        git \
        guile \
# This package isn't available in Centos 8. This means rustc caching won't be recognizable by crave's automated script
        #hardening-check \
        java-1.8.0-openjdk-devel \
        jq \
        libevent-devel \
        make \
        ncurses-devel \
# Installed above
        #ninja-build \
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
# Install the git-lfs package by default
 && yum install -y git-lfs \
# Install the latest git
 && export GIT_VER=2.35.1 \
 && yum install -y \
    expat-devel \
    gettext \
    gnutls-devel \
    libcurl-devel \
    libzip-devel \
    openssl-devel \
    unzip \
 && cd /tmp && wget -q https://github.com/git/git/archive/refs/tags/v${GIT_VER}.tar.gz \
 && tar -xf v${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; sudo rm -rf v${GIT_VER}.tar.gz git-${GIT_VER} \
# Download and install the latest tmux
 && export TMUX_VERSION=3.2 \
 && cd /tmp && wget https://github.com/tmux/tmux/releases/download/3.2/tmux-${TMUX_VERSION}.tar.gz \
 && tar -xf tmux-${TMUX_VERSION}.tar.gz && cd tmux-${TMUX_VERSION} \
 && LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local \
 && make -j `nproc` \
 && sudo make install \
 && cd .. && rm -rf tmux-${TMUX_VERSION}* \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
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
# Install gradle
 && wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp \
 && sudo unzip -d /opt/gradle /tmp/gradle-5.0-bin.zip \
 && rm /tmp/gradle-5.0-bin.zip

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8 \
    GRADLE_HOME=/opt/gradle/gradle-5.0 \
    PATH=/opt/gradle/gradle-5.0/bin/:/home/admin/.local/bin:/home/admin/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
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
