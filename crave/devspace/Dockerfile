# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/xpra:22.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
# Update the underlying base image
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
# Install LXDE + a bunch of x utilities for VNC and a browser, a decent ide, some monitoring tools
 && sudo apt-get install -y \
      arc-theme \
      bmon \
      cscope \
      exuberant-ctags \
      gnome-themes-standard \
      gtk2-engines-murrine \
      gtk2-engines-pixbuf \
      htop \
      iputils-ping \
      lxde \
      multitail \
      net-tools \
      python3-meld3 \
      software-properties-common \
      supervisor \
      task-lxde-desktop \
      telnet \
      vim-gtk3 \
      x11vnc \
      xvfb \
# Fix a problem in xfwm4
 && sudo add-apt-repository ppa:xubuntu-dev/staging \
 && sudo apt update \
 && sudo apt upgrade -y \
# Get rid of the firefox snap and install it from PPA so that it is a regular debian package
 && sudo apt-get purge -y firefox \
 && sudo add-apt-repository ppa:mozillateam/ppa \
 && echo 'Package: *' | sudo tee /etc/apt/preferences.d/mozilla-firefox \
 && echo 'Pin: release o=LP-PPA-mozillateam' | sudo tee -a /etc/apt/preferences.d/mozilla-firefox \
 && echo 'Pin-Priority: 1001' | sudo tee -a /etc/apt/preferences.d/mozilla-firefox \
 && sudo apt-get update \
 && sudo apt-get install -y --allow-downgrades firefox \
# Install the GRPC tool for crave clone
 && mkdir -p /tmp/grpcurl_download \
 && LOCATION=$(curl -s https://api.github.com/repos/fullstorydev/grpcurl/releases/latest \
       | grep "tag_name" \
       | awk '{print "https://github.com/fullstorydev/grpcurl/releases/download/v" substr($2, 3, length($2)-4) "/grpcurl_" substr($2, 3, length($2)-4) "_linux_x86_64.tar.gz"}') \
 && curl -L $LOCATION | tar xvz -C /tmp/grpcurl_download \
 && sudo cp /tmp/grpcurl_download/grpcurl /usr/bin \
 && rm -rf /tmp/grpcurl_download \
# Get the latest version of repo
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mkdir -p /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# Remove python 2 completely
 && sudo apt-get purge -y python python2.7 \
 && sudo apt-get -y autoremove \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
# Make sure that the default version of python is 3
 && if [ $(python --version | grep -c 'Python 3') -eq "0" ] ; then exit 1 ; fi \
# LXDE tweaks
 && mkdir -p /home/admin/.config/pcmanfm/LXDE/ \
# The usual cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

# Put the supervisor conf where it needs to be
COPY vnc.conf /etc/supervisor/conf.d/
# Put the tmux conf where it should be
COPY tmux.conf /home/admin/.tmux.conf
# Copy the init script to its intended location
COPY init.sh /etc/crave/

#COPY startup.sh /home/admin/
#ENTRYPOINT [ "/home/admin/startup.sh" ]
