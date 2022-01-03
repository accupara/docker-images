# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/centos:6 as remake
RUN set -x \
 && sudo yum update -y \
 && sudo yum install -y \
    flex \
    glibc-devel.i686 \
    gmp \
    libgcc.i686 \
    libunistring \
    perl \
    readline-devel \
    svn \
    texinfo-tex \
    zip \
# Download and install the latest gcc
 && export GCC_VER=9_2_0 \
 && mkdir ~/GCC-source && cd ~/GCC-source \
 && svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_${GCC_VER}_release/ >/dev/null \
 && cd gcc_${GCC_VER}_release/ \
 && ./contrib/download_prerequisites \
 && mkdir ../gcc_${GCC_VER}_release-build && cd ../gcc_${GCC_VER}_release-build \
 && ../gcc_${GCC_VER}_release/configure --disable-multilib \
 && make -j `nproc` \
 && sudo make install \
# Fetch gettext sources and compile them
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz \
 && tar -xf gettext-0.21.tar.gz \
 && cd gettext-0.21 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Download and install autoconf
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz \
 && tar -xf autoconf-2.71.tar.gz \
 && cd autoconf-2.71 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Download and install automake
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.gz \
 && tar -xf automake-1.16.5.tar.gz \
 && cd automake-1.16.5 \
 && ./configure --prefix=/usr \
 && make -j `nproc` \
 && sudo make install \
# Download and install pkg-config
 && cd /home/admin \
 && wget -q --no-check-certificate https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz \
 && tar -xf pkg-config-0.29.2.tar.gz \
 && cd pkg-config-0.29.2 \
 && ./configure --with-internal-glib \
 && make -j `nproc` \
 && sudo make install \
# Get the remake sources for 4.3 and compile them
 && cd /home/admin \
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && sed 's/AM_PROG_AR/m4_ifdef([AM_PROG_AR], [AM_PROG_AR])/g' configure.ac > configure.ac.new && mv configure.ac.new configure.ac \
 && grep -v AC_PREREQ configure.ac >configure.ac.new && mv configure.ac.new configure.ac \
 && ./autogen.sh --without-guile \
 && make -j `nproc` \
 && mv ./make /tmp/

################## The real container starts here ##################
FROM centos:6
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

COPY sshd_config limits.conf github_git-lfs.repo /tmp/
COPY --from=remake /tmp/make /usr/bin/remake

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
        emacs \
        gcc gcc-c++ \
        gettext \
        git \
        hardening-check \
        java-1.8.0-openjdk-devel \
        libevent2-devel \
        make \
        ncurses-devel \
        ninja-build \
        openssh-server \
        redhat-lsb \
        rpm-build \
        rsync \
        subversion \
        sudo \
        vim \
        wget \
# Install the WANDisco to get git v2
 && sudo yum install -y http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm \
# Add the github-lfs repo so that we have the latest git-lfs client
 && sudo mv /tmp/github_git-lfs.repo /etc/yum.repos.d/ \
# Add the EPEL 6 repo.... from the archives instead of the live rpm. Centos 6 is EOL'd!
# && yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
 && yum install -y https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/epel-release-6-8.noarch.rpm \
 && yum update -y \
# Install git-lfs and jq separately
 && yum install -y \
    git \
    git-lfs \
    jq \
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
 && cat /etc/sudoers | sed '/Defaults.*requiretty/,+1 d' >/tmp/sudoers ; mv /tmp/sudoers /etc/sudoers \
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
    PATH=/opt/gradle/gradle-5.0/bin/:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

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
