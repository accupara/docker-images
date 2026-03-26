# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved

# Compile remake and rsync on the fly and keep it ready for the next stage
# Chicken or egg : Which came first?
FROM ubuntu:16.04 AS remake
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
 && git clone https://github.com/rocky/remake.git \
 && cd remake \
 && ./autogen.sh \
 && ./configure \
 && make -j `nproc` \
 && mv ./make /tmp/

FROM ubuntu:16.04 AS rsync
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
 && ./configure --prefix=/tmp/rsync --disable-xxhash --disable-zstd \
# This command fails because of the stupid way the linker needs the correct order, but the Makefile isn't written in a way to support that.
 && make -j `nproc` \
 && make install \
 && strip /tmp/rsync/bin/rsync

################## The real container starts here ##################
FROM ubuntu:16.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

COPY sshd_config /tmp/

# https://mirrors.edge.kernel.org/pub/software/scm/git/ ### 2.48.1 is the last one that will compile
# https://gradle.org/releases/
# https://github.com/ninja-build/ninja/releases
ENV GIT_VER=2.48.1 \
    GIT_LFS_VER=3.6.0 \
    OPENSSL_VER=3.0.19 \
    GRADLE_VER=8.7 \
    NINJA_VER=v1.12.1 \
    GIT_TERMINAL_PROMPT=0

# Install the minimum tools
RUN set -x \
 && apt-get update \
 && apt-get install -y eatmydata \
 && eatmydata apt-get -y dist-upgrade \
 && eatmydata apt-get install -y \
      bash-completion \
      binutils \
      build-essential \
      curl \
      debhelper \
      devscripts \
      dh-make \
      eatmydata \
      emacs \
      guile-2.0 \
      jq \
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
      vim-nox \
      wget \
      # for lndir
      xutils-dev \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
# Install the latest git
 && eatmydata apt-get install -y \
      autoconf \
      git \
      libcurl4-gnutls-dev \
      libexpat1-dev \
      libpsl-dev \
      libssl-dev \
      libtool \
      zlib1g-dev \
# Download, build and install OpenSSL >= 3, because curl and git needs it
 && cd /tmp/dl \
 && wget https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz \
 && tar -xf openssl-${OPENSSL_VER}.tar.gz \
 && cd openssl-${OPENSSL_VER} \
 && ./config --prefix=/opt/openssl3 --openssldir=/opt/openssl3 shared zlib \
 && make -j $(nproc) \
# Test everything but AF_ALG because it is not supported in Centos 7.
# AF_ALG tests fail with "socket: Operation not supported" error and it is not possible to skip only AF_ALG tests, so skipping all tests for now.
# This is better than having some tests fail and cause confusion.
 && make test TESTS='-test_afalg' \
 && sudo make install \
# Different library directories depending on the architecture. For example, in x86_64 it is lib64 and in aarch64 it is lib. So add the right one to the ldconfig path
 && export OPENSSL_LIBDIR=$(find /opt/openssl3 -name libssl.so.3 | xargs dirname) \
 && echo "$OPENSSL_LIBDIR" | sudo tee /etc/ld.so.conf.d/openssl3.conf \
 && sudo ldconfig \
 && /opt/openssl3/bin/openssl version | grep ${OPENSSL_VER} \
 && if [ $(/opt/openssl3/bin/openssl version | grep -c ${OPENSSL_VER}) = "1" ] ; then \
        echo found ; \
    else \
        /opt/openssl3/bin/openssl version \
        /opt/openssl3/bin/openssl version | grep -c ${OPENSSL_VER} \
        echo "Incorrect OpenSSL version" ; \
        exit 1 ; \
    fi \
# Purge the system libcurl dev package so the linker doesn't pick up the old 
# version (7.47.0) from the multiarch directory during git compilation.
 && sudo apt-get purge -y libcurl4-gnutls-dev \
# compile libcurl
 && cd /tmp/dl \
 && git clone https://github.com/curl/curl.git curl \
 && cd curl \
 && autoreconf -fi \
 && ./configure \
    --with-openssl=/opt/openssl3 \
    --prefix /usr \
    LDFLAGS="-L$OPENSSL_LIBDIR" \
 && make -j `nproc` \
 && sudo make install \
# Then compile git with this libcurl
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && ./configure --prefix=/usr \
        CFLAGS="-I/opt/openssl3/include -DNO_GETRANDOM" \
        LDFLAGS="-L/usr/lib -L$OPENSSL_LIBDIR" \
        --with-openssl=/opt/openssl3 \
 && make all -j `nproc` 2>&1 | tee /tmp/git.build.log \
 && sudo make install -j `nproc` 2>&1 | tee -a /tmp/git.build.log \
 && if [ $(git --version | grep -c $GIT_VER) = "1" ] ; then \
        echo "Correct git version" ; \
    else \
        echo "Incorrect git version" ; \
        exit 1 ; \
    fi \
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
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
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
 && cd /tmp \
 && find /tmp/dl -delete \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8 \
    GIT_TERMINAL_PROMPT=0 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/git-core
WORKDIR /home/admin
CMD ["/bin/bash"]

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
 && sudo locale-gen en_US.UTF-8 \
 && sudo update-locale LANG=en_US.UTF-8 \
# Export env vars
 && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc \
# Initialize LFS
 && git lfs install \
 && git config --global filter.lfs.smudge "git-lfs smudge -- %f" \
# Install JFrog CLI only fo x84_64
 && if [ $(uname -m) = "x86_64" ] ; then \
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
