# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM archlinux:latest 
#TODO: Add arch to baseimages

ENV YQ_VER=4.40.3

COPY sshd_config /tmp/
RUN set -x && \
  # Install packages
  pacman -Sy --noconfirm \
  && pacman -Syu base-devel bash-completion binutils cmake extra-cmake-modules cargo curl emacs ffmpeg git git-lfs guile jq meson ninja popt xxhash github-cli gradle lsb-release lsb-release ninja openssh openssl pacman-contrib psmisc remake repo rsync subversion sudo tmux vim neovim wget neofetch --noconfirm \
  && pacman -Sc --noconfirm \
  && /usr/bin/ssh-keygen -A \
  && mkdir -p /etc/crave \
  && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
  && chmod +x /etc/crave/create_build_tools_json.sh \
  && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
  && mv crave /usr/local/bin/ \
  && useradd -ms /bin/bash admin \
  && echo "admin:admin" | chpasswd \
  && usermod -aG wheel admin \
  && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir -p /var/run/sshd \
  && mv /tmp/sshd_config /etc/ssh/sshd_config 
USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /home/admin
CMD /bin/bash
RUN set -x \
  && sudo chown -R admin:admin /home/admin \
  && echo ". /usr/share/bash-completion/bash_completion" >> /home/admin/.bashrc \
  && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
  && mkdir /home/admin/.ssh \
  && chmod 700 /home/admin/.ssh \
  && touch /home/admin/.ssh/authorized_keys \
  && sudo chmod 0600 /etc/ssh/* \
  && echo 'en_US.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen \
  && sudo locale-gen \
  && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
  && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
  && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc \
  && sudo mkdir -p /opt/aosp \
  && sudo chown admin:admin /opt/aosp \
  && echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf \
  && sudo pacman -Syy \
  && wget https://omansh.vercel.app/api/raw/?path=/omansh/pkgs/lib32-ncurses5-compat-libs/lib32-ncurses5-compat-libs-6.4-1-x86_64.pkg.tar.zst \
  && sudo pacman -U ./*zst --noconfirm && rm *zst \
  && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd .. && rm -rf paru \
  && paru -S multilib-devel aosp-devel lineageos-devel python2 jdk8-openjdk --noconfirm \
  && sudo archlinux-java set java-8-openjdk \
  && java -version \
  && neofetch \
  && sudo ln -sf /usr/bin/python2 /usr/bin/python
  # This is required for AOSP compilations
  && git config --global user.name Crave \
  && git config --global user.email aosp@crave.io \
  # Please stop asking what colors I want
  && git config --global color.ui false \


RUN sudo chmod 777 /etc/mke2fs.conf

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0

EXPOSE 22

COPY resync.sh /opt/crave/