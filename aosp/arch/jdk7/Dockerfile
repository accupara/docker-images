# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/archlinux:latest 

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0 \
    XDG_DOWNLOAD_DIR="/home/admin/Downloads"

RUN set -x \
# Install packages
 && sudo pacman -Sy --noconfirm \
 && sudo pacman -Syu \
    --noconfirm \
    cmake \
    extra-cmake-modules \
 && sudo pacman -Sc --noconfirm \
# Multitlib needed to install and run jdk7
 && sudo mkdir -p /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf \
 && sudo pacman -Syy \
 && wget https://omansh.vercel.app/api/raw/?path=/omansh/pkgs/lib32-ncurses5-compat-libs/lib32-ncurses5-compat-libs-6.4-1-x86_64.pkg.tar.zst \
 && sudo pacman -U ./*zst --noconfirm && rm *zst \
 && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd .. && rm -rf paru \
# Now lets fetch the jdk7 and install it
 && mkdir /home/admin/Downloads || true \
 && wget -P /home/admin/Downloads https://mirrors.huaweicloud.com/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz \
 && paru -S multilib-devel aosp-devel lineageos-devel python2 jdk7 --noconfirm \
 && sudo archlinux-java status \
 && sudo archlinux-java set java-7-jdk \
 && java -version \
 && neofetch \
 && sudo ln -sf /usr/bin/python2 /usr/bin/python \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Save the resync.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/ \
 && sudo chown admin:admin /opt/crave/ \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/resync.sh -O /opt/crave/

RUN sudo chmod 777 /etc/mke2fs.conf
