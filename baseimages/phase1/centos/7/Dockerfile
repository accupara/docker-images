# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved

# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM centos:7 AS remake
RUN set -x \
 && sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo \
 && sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo \
 && sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo \
 && yum update -y \
 && yum install -y \
    autoconf \
    automake \
    binutils \
    flex \
    gcc gcc-c++ \
    glibc-devel \
    gettext-devel \
    guile-devel \
    make \
    patch \
    perl \
    readline-devel \
    svn \
    texinfo \
    texinfo-tex \
    wget \
    zip \
# Download and install automake
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.gz \
 && tar -xf automake-1.16.5.tar.gz \
 && cd automake-1.16.5 \
 && ./configure --prefix=/usr \
 && make -j `nproc` \
 && make install \
 && cd .. \
# Get the remake sources for 4.3 and compile them
 && wget -q https://github.com/Trepan-Debuggers/remake/archive/refs/tags/remake-4.3+dbg-1.6.tar.gz -O remake.tar.gz \
 && tar -xf remake.tar.gz \
 && mv remake-remake-4.3-dbg-1.6 remake \
 && cd remake \
 && ./autogen.sh \
 && make -j `nproc` \
 && mv ./make /tmp/

# The binary generated from this step works in centos 6 and 7, and ubuntu 14.04,16.04,18.04,20.04. It does not work in 22.04
FROM centos:7 AS rsync
RUN set -x \
 && sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo \
 && sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo \
 && sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo \
 && yum update -y \
 && yum install -y \
    autoconf \
    automake \
    binutils \
    gcc gcc-c++ \
    glibc-static \
    popt-static \
    libzstd-devel \
    libzstd-static \
    lz4-devel \
    lz4-static \
    make \
    openssl-static \
    wget \
 && export RSYNC_VER=3.2.7 \
 && wget https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VER}.tar.gz -O rsync-${RSYNC_VER}.tar.gz \
 && tar -xf rsync-${RSYNC_VER}.tar.gz \
 && ls -l \
 && cd rsync-${RSYNC_VER} \
 && ./configure --prefix=/tmp/rsync --disable-xxhash --disable-zstd \
 && make -j `nproc` \
 && make install

################## The real container starts here ##################
FROM centos:7
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# Git: https://mirrors.edge.kernel.org/pub/software/scm/git/
# Gradle: https://gradle.org/releases/
# Tmux: https://github.com/tmux/tmux/releases
ENV GIT_VER=2.47.1 \
    GIT_LFS_VER=3.6.0 \
    GRADLE_VER=8.7 \
    TMUX_VERSION=3.3 \
    GIT_TERMINAL_PROMPT=0

COPY sshd_config limits.conf /tmp/

# Install the minimum tools
RUN set -x \
# Centos mirror lists are decommissioned
 && sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo \
 && sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo \
 && sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo \
 && yum update -y \
 && yum install -y \
      autoconf \
      automake \
      binutils \
      curl \
      emacs \
      epel-release \
      gcc gcc-c++ \
      gettext \
      git \
      guile \
      hardening-check \
      java-1.8.0-openjdk-devel \
      libevent-devel \
      make \
      ncurses-devel \
      ninja-build \
      openssh-clients \
      openssh-server \
      redhat-lsb \
      rpm-build \
      subversion \
      sudo \
      vim \
      wget \
# install rsync because it allows the updated rsync to work correctly
 && yum install -y \
      rsync \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
# Download and install the latest tmux
 && cd /tmp/dl \
 && wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz \
 && tar -xf tmux-${TMUX_VERSION}.tar.gz && cd tmux-${TMUX_VERSION} \
 && LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local \
 && make -j `nproc` \
 && make install \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add the crave binary into the base image
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && mv crave /usr/local/bin/ \
# Add admin user and add it to sudoers
 && sed '/Defaults.*requiretty/,+1 d' /etc/sudoers >/tmp/sudoers \
  ; mv -f /tmp/sudoers /etc/sudoers \
 && useradd -u 1000 -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -aG wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers \
# Pre-configure the ssh server
 && mkdir -p /var/run/sshd \
 && ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/sshd \
 && echo "session    required     pam_limits.so" >> /etc/pam.d/login \
 && mv -f /tmp/sshd_config /etc/ssh/ \
 && chmod 0600 /etc/ssh/* \
 && mv -f /tmp/limits.conf /etc/security/ \
# Install the latest version of gradle
 && cd /tmp/dl \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && cd /tmp && find /tmp/dl -delete

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8 \
    GRADLE_HOME=/opt/gradle/gradle-${GRADLE_VER} \
    PATH=/opt/gradle/gradle-${GRADLE_VER}/bin/:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GIT_TERMINAL_PROMPT=0
WORKDIR /home/admin

RUN set -x \
 && sudo chown -R admin:admin /home/admin \
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
# Install jq separately
 && sudo yum install -y \
      libzstd \
      jq \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
# Install the latest git
 && sudo yum install -y \
    eatmydata \
    expat-devel \
    gettext \
    gnutls-devel \
    libcurl-devel \
    libzip-devel \
    openssl-devel \
    unzip \
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" all -j `nproc` 2>&1 | tee /tmp/git.build.log \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" install -j `nproc` 2>&1 | tee -a /tmp/git.build.log \
# Make sure to install git-lfs the direct way. no mucking around with apt
 && cd /tmp/dl \
 && arch="$(uname -m)"; \
       case "$arch" in \
              x86_64)  lfsArch='amd64' ;; \
              aarch64) lfsArch='arm64' ;; \
              ppc64le) lfsArch='ppc64le' ;; \
              s390x) lfsArch='s390x' ;; \
              *) echo >&2 "error: unsupported architecture ($arch)"; exit 1 ;;\
       esac \
 && wget -q https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VER}/git-lfs-linux-$lfsArch-v${GIT_LFS_VER}.tar.gz \
 && tar -xf git-lfs-linux-$lfsArch-v${GIT_LFS_VER}.tar.gz \
 && cd git-lfs-${GIT_LFS_VER} \
 && sudo ./install.sh \
# Initialize the Git LFS
 && git lfs install \
# Prevent auto install of git
 && echo "exclude=git*" | sudo tee -a /etc/yum.conf \
# Install JFrog CLI only fo x84_64
 && if [ $(uname -m) == "x86_64" ] ; then \
         echo "[jfrog-cli]" >jfrog-cli.repo \
      && echo "name=jfrog-cli" >>jfrog-cli.repo \
      && echo "baseurl=https://releases.jfrog.io/artifactory/jfrog-rpms" >>jfrog-cli.repo \
      && echo "enabled=1" >> jfrog-cli.repo \
      && sudo rpm --import https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key \
      && sudo mv jfrog-cli.repo /etc/yum.repos.d/ \
      && sudo yum install -y jfrog-cli jfrog-cli-v2-jf \
  ; fi \
# Cleanup
 && cd /tmp && find /tmp/dl -delete

# Copy these at the very end
COPY --from=remake /tmp/make /usr/bin/remake
COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
CMD ["/bin/bash"]
