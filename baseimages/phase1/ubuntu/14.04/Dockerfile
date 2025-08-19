# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved

# Compile remake and rsync on the fly and keep it ready for the next stage
# Chicken or egg : Which came first?
FROM ubuntu:14.04 AS remake
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
      autoconf \
      autopoint \
      build-essential \
      git \
      guile-2.0-dev \
      pkg-config \
      rsync \
      texinfo \
      wget \
# Fetch gettext sources and compile them
 && wget -q --no-check-certificate https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz \
 && tar -xf gettext-0.21.tar.gz \
 && cd gettext-0.21 \
 && ./configure \
 && make -j `nproc` \
 && make install \
# Get the remake sources for 4.3 and compile them
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh \
 && ./configure --enable-maintainer-mode \
 && make -j `nproc` \
 && mv ./make /tmp/

FROM ubuntu:14.04 AS rsync
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && export GNUTLS_CPUID_OVERRIDE=0x1 \
 && apt-get update -y \
 && apt-get install -y \
      build-essential \
      libpopt-dev \
      libssh-dev \
      liblz4-dev \
      wget \
      zlib1g-dev \
 && export RSYNC_VER=3.2.7 \
 && wget -q https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VER}.tar.gz -O rsync-${RSYNC_VER}.tar.gz \
 && tar -xf rsync-${RSYNC_VER}.tar.gz \
 && cd rsync-${RSYNC_VER} \
 && ./configure --prefix=/tmp/rsync --disable-xxhash --disable-zstd --disable-lz4 \
# This command fails because of the stupid way the linker needs the correct order, but the Makefile isn't written in a way to support that.
 && make -j `nproc` \
 && make install \
 && strip /tmp/rsync/bin/rsync

################## The real container starts here ################## 
FROM ubuntu:14.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# https://mirrors.edge.kernel.org/pub/software/scm/git/
# https://gradle.org/releases/
# https://github.com/ninja-build/ninja/releases
ENV GIT_VER=2.50.1 \
    GIT_LFS_VER=3.6.0 \
    CURL_VER=8.12.1 \
    PY3_VER=3.8.20 \
    GRADLE_VER=8.7 \
    NINJA_VER=v1.12.1 \
    GIT_TERMINAL_PROMPT=0

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && export GNUTLS_CPUID_OVERRIDE=0x1 \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        debhelper \
        devscripts \
        dh-make \
        eatmydata \
        emacs \
        gettext \
        guile-2.0 \
        jq \
        libexpat1-dev \
        liblz4-1 \
        libpopt0 \
        locales \
        lsb-release \
        multitail \
        ninja-build \
        openssh-server \
        psmisc \
        # install rsync because it allows the updated rsync to work correctly
        rsync \
        subversion \
        sudo \
        tmux \
        unzip \
        vim-nox \
        wget \
        zlib1g \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
# Install OpenSSL 1.1, for curl and py3.8
 && wget -q https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-1.1.1w.tar.gz \
 && tar -xf openssl-1.1.1w.tar.gz \
 && cd openssl-1.1.1w \
 && ./config shared --prefix=/usr/local --libdir=lib --openssldir=/etc/ssl \
 && make all -j`nproc` \
 && make install \
 && cd /tmp/dl \
# Install nghttp2, HTTP/2 dependency of curl
 && wget -q https://github.com/nghttp2/nghttp2/releases/download/v1.64.0/nghttp2-1.64.0.tar.gz \
 && tar -xf nghttp2-1.64.0.tar.gz \
 && cd nghttp2-1.64.0 \
 && ./configure --prefix=/usr --enable-lib-only \
 && make all -j`nproc` \
 && make install \
 && cd /tmp/dl \
# Install libpsl, another dependency of curl
 && eatmydata apt-get install -y libunistring-dev \
 && wget -q https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz \
 && tar -xf libpsl-0.21.5.tar.gz \
 && cd libpsl-0.21.5 \
 && ./configure --prefix=/usr \
 && make all -j`nproc` \
 && make install \
 && cd /tmp/dl \
# Install curl, a dependency of git
 && wget -q https://curl.se/download/curl-${CURL_VER}.tar.gz \
 && tar -xf curl-${CURL_VER}.tar.gz \
 && cd curl-${CURL_VER} \
 && ./configure --prefix=/usr/local --with-openssl=/usr/local \
 && make all -j`nproc` \
 && make install \
 && cd /tmp/dl \
# Install the last python3.8 (tk module disabled)
 && eatmydata apt-get install -y gdb lcov pkg-config libbz2-dev libffi-dev libgdbm-dev liblzma-dev libncurses5-dev libreadline6-dev libsqlite3-dev lzma lzma-dev uuid-dev zlib1g-dev libmpdec-dev systemtap-sdt-dev \
 && wget -q https://www.python.org/ftp/python/${PY3_VER}/Python-${PY3_VER}.tgz \
 && tar xzf Python-${PY3_VER}.tgz \
 && cd Python-${PY3_VER} \
 && sed -i "s/#SSL=/SSL=/" Modules/Setup \
 && ./configure --prefix=/usr/local --enable-shared --with-openssl=/usr/local --enable-ipv6 --enable-loadable-sqlite-extensions --with-dbmliborder=bdb:gdbm --with-computed-gotos --with-system-expat --with-dtrace --with-system-libmpdec --with-system-ffi --with-fpectl --with-wheel-pkg-dir=/usr/share/python-wheels/ \
 && make all -j`nproc` \
 && make altinstall \
 && ln -sf /usr/local/bin/python3.8 /usr/bin/python3 \
 && cd /tmp/dl \
# Install the latest git
 && eatmydata apt-get install -y \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && OPENSSLDIR=/usr/local ./configure --with-openssl --libexecdir=/usr/lib \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all -j `nproc` \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
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
 && ./install.sh \
# Install the latest version of gradle
 && cd /tmp/dl \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && sudo mv gradle-${GRADLE_VER} /usr/lib/ \
 && sudo ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
# Install the latest version of repo, as described in https://gerrit.googlesource.com/git-repo
 && cd /tmp/dl \
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# Add the latest version of the ninja-build
 && cd /tmp/dl \
 && wget https://github.com/ninja-build/ninja/releases/download/${NINJA_VER}/ninja-linux.zip \
 && unzip ninja-linux.zip \
 && chmod +x ninja \
 && sudo mv ninja /usr/bin/ \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add the crave binary into the base image
 && (curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- && mv crave /usr/local/bin/) || true \
# Clean up image
 && cd /tmp \
 && find /tmp/dl -delete \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
# Bash completion and admin in sudoers
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
    TERM=xterm \
    GIT_TERMINAL_PROMPT=0 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/git-core
WORKDIR /home/admin
CMD ["/bin/bash"]

RUN set -x \
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/* \
# Initialize LFS
 && git lfs install \
 && git config --global filter.lfs.smudge "git-lfs smudge -- %f" \
# Install JFrog CLI only fo x84_64
 && if [ $(uname -m) == "x86_64" ] ; then \
       wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo apt-key add - \
    && echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list \
    && sudo apt-get update \
    && sudo apt-get install -y \
            jfrog-cli \
            jfrog-cli-v2-jf \
  ; fi \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

# Copy these at the very end
COPY --from=remake /tmp/make /usr/bin/remake
COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
