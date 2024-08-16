# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

## Note: no remake compilation here because we're going to use the distro supplied remake
FROM archlinux/archlinux:multilib-devel

LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

COPY sshd_config /tmp/

# Install the minimum tools
RUN set -x \
# Install packages
 && pacman -Syu \
    --noconfirm \
    base-devel \
    bash-completion \
    binutils \
    cargo \
    curl \
    emacs \
    ffmpeg \
    git \
    git-lfs \
    github-cli \
    gradle \
    guile \
    jq \
    lsb-release \
    meson \
    neofetch \
    neovim \
    ninja \
    openssh \
    openssl \
    pacman-contrib \
    popt \
    psmisc \
    remake \
    rsync \
    subversion \
    sudo \
    tmux \
    vim \
    wget \
    xxhash \
    iputils \
    inetutils \
    xmlstarlet \
# Newest versions of openssh-server don't seem to create all the host keys
 && sudo /usr/bin/ssh-keygen -A \
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
 && usermod -aG wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
# Configure sshd
 && mkdir -p /var/run/sshd \
 && mv /tmp/sshd_config /etc/ssh/sshd_config \
# Clean up image
 && echo ". /etc/bash_completion" >>/root/.bashrc

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
 && echo 'en_US.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen \
 && sudo locale-gen \
 && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc \
# Install paru
 && git clone https://aur.archlinux.org/paru.git \
 && cd paru \
 && makepkg -si --noconfirm \
 && cd .. \
 && rm -rf paru \
# Cleanup
 && sudo pacman -Sc --noconfirm \
 && sudo rm -rf $HOME/.cargo /var/cache/pacman/

EXPOSE 22
