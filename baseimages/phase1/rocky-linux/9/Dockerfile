# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved

FROM accupara/rockylinux:9 AS remake
RUN set -x \
 && dnf update -y \
 && dnf install -y 'dnf-command(config-manager)' \
 && dnf config-manager --enable devel \
 && dnf config-manager --enable extras \
 && dnf config-manager --enable plus \
 && dnf update -y \
 && dnf group install -y "Development Tools" \
 && dnf install -y \
    flex \
    glibc-devel \
    gettext-devel \
    guile-devel \
    libgcc \
    perl \
    readline-devel \
    rsync \
    svn \
    texinfo \
    texinfo-tex \
    wget \
    zip \
# Download and install automake
 && cd /tmp \
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.gz \
 && tar -xf automake-1.16.5.tar.gz \
 && cd automake-1.16.5 \
 && ./configure --prefix=/usr \
 && make -j `nproc` \
 && make install \
# Get the remake sources for 4.3 and compile them
 && cd /tmp \
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh \
# Get rid of the pot files
 && sed -i -s 's/SUBDIRS\(.*\) po \(.*\)/SUBDIRS\1 \2/g' Makefile \
 && make -j `nproc` \
 && mv ./make /tmp/

FROM rockylinux:9 AS rsync
RUN set -x \
 && dnf update -y \
 && dnf install -y 'dnf-command(config-manager)' \
 && dnf config-manager --enable devel \
 && dnf config-manager --enable extras \
 && dnf config-manager --enable plus \
 && dnf update -y \
 && dnf group install -y "Development Tools" \
 && dnf install -y \
   glibc-static \
   popt-static \
   libzstd-devel \
   lz4-devel \
   lz4-static \
   openssl-devel \
 && export RSYNC_VER=3.2.7 \
 && curl https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VER}.tar.gz -o rsync-${RSYNC_VER}.tar.gz \
 && tar -xf rsync-${RSYNC_VER}.tar.gz \
 && cd rsync-${RSYNC_VER} \
 && ./configure --prefix=/tmp/rsync --disable-xxhash \
# Get rid of the pot files
 && sed -i -s 's/SUBDIRS\(.*\) po \(.*\)/SUBDIRS\1 \2/g' Makefile \
 && make -j `nproc` \
 && make install

################## The real container starts here ##################
FROM rockylinux:9
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

COPY sshd_config limits.conf /tmp/

# Install the minimum tools
RUN set -x \
 && dnf update -y \
 && dnf install -y 'dnf-command(config-manager)' \
 && dnf config-manager --enable devel \
 && dnf config-manager --enable extras \
 && dnf config-manager --enable plus \
 && dnf update -y \
 && dnf install -y \
      autoconf \
      automake \
      binutils \
      #curl \
      emacs \
      epel-release \
      gcc gcc-c++ \
      gettext \
      #guile \
      #hardening-check \
      java-1.8.0-openjdk-devel \
      jq \
      libevent-devel \
      make \
      ncurses-devel \
      ninja-build \
      openssh-clients \
      openssh-server \
      redhat-lsb \
      rpm-build \
      # install rsync because it allows the updated rsync to work correctly
      rsync \
      subversion \
      sudo \
      vim \
      wget \
# Download and install the latest tmux
 && export TMUX_VERSION=3.2 \
 && cd /tmp && wget https://github.com/tmux/tmux/releases/download/3.2/tmux-${TMUX_VERSION}.tar.gz \
 && tar -xf tmux-${TMUX_VERSION}.tar.gz && cd tmux-${TMUX_VERSION} \
 && LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local \
 && make -j `nproc` \
 && make install \
 && cd .. && rm -rf tmux-${TMUX_VERSION}* \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add the crave binary into the base image
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && mv crave /usr/local/bin/ \
# Add admin user and add it to sudoers
 && cat /etc/sudoers | sed '/Defaults.*requiretty/,+1 d' >/tmp/sudoers \
  ; mv /tmp/sudoers /etc/sudoers \
 && useradd -u 1000 -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -aG wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers \
# Pre-configure the ssh server
 && mkdir -p /var/run/sshd \
 && ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/sshd \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/login \
 && mv /tmp/sshd_config /etc/ssh/ \
 && chmod 0600 /etc/ssh/* \
 && mv /tmp/limits.conf /etc/security/ \
# Just in case: Remove the nologin file that prevents the user from ssh-ing into this container
 && rm -f /run/nologin \
# Install the latest version of gradle
 && cd /tmp \
 && export GRADLE_VER=7.4.2 \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && rm gradle-${GRADLE_VER}-bin.zip

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8 \
    GRADLE_HOME=/opt/gradle/gradle-5.0 \
    PATH=/opt/gradle/gradle-5.0/bin/:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GIT_TERMINAL_PROMPT=0
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
 && touch /home/admin/.ssh/authorized_keys \
# Install git-lfs and jq separately
 && sudo dnf install -y \
      git-lfs \
      libzstd \
      jq \
# Install the latest git
 && export GIT_VER=2.50.1 \
 && sudo dnf install -y \
    expat-devel \
    gettext \
    gnutls-devel \
    libcurl-devel \
    libzip-devel \
    openssl-devel \
    unzip \
 && cd /tmp && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" all -j `nproc` 2>&1 | tee /tmp/git.build.log \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" install 2>&1 | tee -a /tmp/git.build.log \
 && cd /tmp ; rm -rf git-${GIT_VER}*

# Copy these at the very end
#COPY --from=remake /tmp/make /usr/bin/remake
COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
CMD ["/bin/bash"]
