# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/archlinux:latest 

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0 \
    XDG_DOWNLOAD_DIR="/home/admin/Downloads"

RUN set -x \
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
  && sudo ln -sf /usr/bin/python2 /usr/bin/python \
  # This is required for AOSP compilations
  && git config --global user.name Crave \
  && git config --global user.email aosp@crave.io \
  # Please stop asking what colors I want
  && git config --global color.ui false

RUN sudo chmod 777 /etc/mke2fs.conf
