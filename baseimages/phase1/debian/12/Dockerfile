# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved

# Compile remake on the fly and keep it ready for the next stage
FROM debian:12 AS remake
COPY id_rsa id_rsa.pub /root/.ssh/
RUN set -x \
 && chmod 400 /root/.ssh/id_rsa* \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
      autoconf \
      autopoint \
      build-essential \
      git \
      guile-2.2-dev \
      pkg-config \
      rsync \
      texinfo \
 && ssh-keyscan github.com >>/root/.ssh/known_hosts \
 && git clone git@github.com:Trepan-Debuggers/remake.git \
 && cd remake \
 && ./autogen.sh \
 && make -j `nproc` \
 && mv ./make /tmp/

################## The real container starts here ##################
FROM debian:12
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

COPY sshd_config /tmp/

# For Git: https://mirrors.edge.kernel.org/pub/software/scm/git/
# Gradle: https://gradle.org/releases/
ENV GIT_VER=2.47.1 \
    GIT_LFS_VER=3.6.0 \
    GRADLE_VER=8.4 \
    GIT_TERMINAL_PROMPT=0

# Install the minimum tools
SHELL ["/bin/bash", "-c"]
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
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
      guile-2.2 \
      jq \
      libpopt0 \
      locales \
      lsb-release \
      ninja-build \
      openssh-server \
      subversion \
      sudo \
      vim-nox \
      wget \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
# Install the latest git
 && eatmydata apt-get install -y \
      libcurl4-gnutls-dev \
      libexpat1-dev \
      libssl-dev \
      zlib1g-dev \
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
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
 && cd /tmp \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && mv gradle-${GRADLE_VER} /usr/lib/ \
 && ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && rm gradle-${GRADLE_VER}-bin.zip \
# Install the latest version of repo, as described in https://gerrit.googlesource.com/git-repo
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add the crave binary into the base image
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && sudo mv crave /usr/local/bin/ \
# Add admin user and add it to sudoers
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
# Configure sshd
 && mkdir -p /var/run/sshd /etc/ssh \
 && mv /tmp/sshd_config /etc/ssh/sshd_config \
# Clean up image
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && cd /tmp && sudo find dl -delete \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8 \
    GIT_TERMINAL_PROMPT=0
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
 && sudo sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
 && sudo locale-gen \
# Export env vars
 && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc \
# Initialize LFS
 && git lfs install \
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
#COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
