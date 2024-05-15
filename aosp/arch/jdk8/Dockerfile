# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/archlinux:latest 

ENV REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0 \
    XDG_DOWNLOAD_DIR="/home/admin/Downloads"

RUN set -x \
# Temporarily move aside the repo and let the distribution's package put it there
 && sudo mv /usr/bin/repo /tmp/ \
 && sudo mkdir -p /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf \
 && sudo pacman -Syy \
# Multitlib needed to install and run jdk7
 && wget -q https://omansh.vercel.app/api/raw/?path=/omansh/pkgs/lib32-ncurses5-compat-libs/lib32-ncurses5-compat-libs-6.4-1-x86_64.pkg.tar.zst \
 && sudo pacman -U ./*zst --noconfirm && rm *zst \
 && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd .. && rm -rf paru \
# Now lets fetch the jdk8 as well any thing ele that older aosp needs
 && paru -S multilib-devel aosp-devel lineageos-devel python2 jdk8-openjdk --noconfirm \
 && sudo archlinux-java set java-8-openjdk \
 && java -version \
 && neofetch \
 && sudo ln -sf /usr/bin/python2 /usr/bin/python \
# Put back repo
 && sudo mv /tmp/repo /usr/bin/ \
# This is required for AOSP compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Save the resync.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/ \
 && sudo chown admin:admin /opt/crave/ \
 && wget -q https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/resync.sh -O /opt/crave/resync.sh \
 && chmod +x /opt/crave/resync.sh \
# Save the upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/github-actions \
 && sudo chown admin:admin /opt/crave/github-actions \
 && wget -q https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/upload.sh -O /opt/crave/github-actions/upload.sh \
 && chmod +x /opt/crave/github-actions/upload.sh \
# Save the telegram upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/telegram \
 && sudo chown -R admin:admin /opt/crave \
 && wget -q https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/tgup.sh -O /opt/crave/telegram/upload.sh \
 && chmod +x /opt/crave/telegram/upload.sh \
# For the DumperX script
 && sudo chmod 777 /etc/mke2fs.conf
