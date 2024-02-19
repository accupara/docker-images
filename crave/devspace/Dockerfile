# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/xpra:22.04

# CI=true is to tell jfrog to be noninteractive
ENV YQ_VER=4.40.3 \
    CI=true

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
# Update the underlying base image
 && sudo eatmydata apt-get -y update \
# Install LXDE + a bunch of x utilities for VNC and a browser, a decent ide, some monitoring tools
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y \
      arc-theme \
      bmon \
      cscope \
      exuberant-ctags \
      fish \
      gnome-themes-standard \
      gtk2-engines-murrine \
      gtk2-engines-pixbuf \
      htop \
      iputils-ping \
      lxde \
      multitail \
      nano \
      net-tools \
      npm \
      python3-meld3 \
      software-properties-common \
      supervisor \
      task-lxde-desktop \
      telnet \
      vim-gtk3 \
      x11vnc \
      xvfb \
      yarnpkg \
# Fix a problem in xfwm4
 && sudo eatmydata add-apt-repository ppa:xubuntu-dev/staging \
 && sudo eatmydata apt update \
 && sudo eatmydata apt upgrade -y \
# Get rid of the firefox snap and install it from PPA so that it is a regular debian package
 && sudo eatmydata apt-get purge -y firefox \
 && sudo eatmydata add-apt-repository ppa:mozillateam/ppa \
 && echo 'Package: *' | sudo tee /etc/apt/preferences.d/mozilla-firefox \
 && echo 'Pin: release o=LP-PPA-mozillateam' | sudo tee -a /etc/apt/preferences.d/mozilla-firefox \
 && echo 'Pin-Priority: 1001' | sudo tee -a /etc/apt/preferences.d/mozilla-firefox \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y --allow-downgrades firefox \
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
 && sudo eatmydata apt-get purge -y python python2.7 \
 && sudo eatmydata apt-get -y autoremove \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
# Make sure that the default version of python is 3
 && if [ $(python --version | grep -c 'Python 3') -eq "0" ] ; then exit 1 ; fi \
# LXDE tweaks
 && mkdir -p /home/admin/.config/pcmanfm/LXDE/ \
# Unminimize so that man pages are present
 && yes | sudo unminimize \
# Make git statuses faster
 && git config --global feature.manyFiles true \
# Add the crane tool
 && wget -q -O /tmp/go-crane.tar.gz https://github.com/google/go-containerregistry/releases/download/v0.15.1/go-containerregistry_Linux_x86_64.tar.gz \
 && mkdir -p /tmp/crane \
 && tar -C /tmp/crane -xvf /tmp/go-crane.tar.gz \
 && sudo mv /tmp/crane/crane /tmp/crane/gcrane /tmp/crane/krane /usr/bin/ \
 && rm -rf /tmp/crane /tmp/go-crane.tar.gz \
# Add the GCloud tools
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y google-cloud-cli \
# Add the AWS tools
 && mkdir -p /tmp/awscli \
 && cd /tmp/awscli \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip \
 && unzip awscliv2.zip \
 && sudo ./aws/install \
 && cd /tmp \
 && rm -rf awscli \
# Add the yq tool from the releases at https://github.com/mikefarah/yq
 && wget -q -O yq https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_amd64 \
 && chmod +x yq \
 && sudo mv yq /usr/bin/ \
# Install the jfrog tool: https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/install
 && wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog\_public\_gpg.key | sudo apt-key add - \
 && echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list \
 && sudo apt-get update \
 && sudo apt-get install -y jfrog-cli-v2 \
# Install the deps for autocompletions for the crave client binary inside devspace sessions
 && sudo eatmydata add-apt-repository -y universe \
 && sudo eatmydata apt-get -y update \
 && sudo eatmydata apt install -y python3-pip \
 && sudo python -m pip -v install argcomplete \
 && mkdir -p /home/admin/.bash_completion.d \
 && register-python-argcomplete crave > /tmp/crave_bash_completion \
 && cp /tmp/crave_bash_completion /home/admin/.bash_completion.d/crave \
 && sudo chown -R admin:admin /home/admin/.bash_completion.d \
# Install the VS Code Server
 && curl -fsSL https://code-server.dev/install.sh | sh \
# The usual cleanup
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

# Copy everything in one shot and then move each file to its appropriate location
COPY vnc.conf tmux.conf sshd_config init.sh /tmp/
RUN set -x \
# Put the supervisor conf where it needs to be
 && sudo mv /tmp/vnc.conf /etc/supervisor/conf.d/ \
# Put the tmux conf where it should be
 && sudo mv /tmp/tmux.conf /home/admin/.tmux.conf \
# Put the sshd conf where it should be
 && sudo mv /tmp/sshd_config /etc/ssh/sshd_config \
# Copy the init script to its intended location
 && sudo mv /tmp/init.sh /etc/crave/

#COPY startup.sh /home/admin/
#ENTRYPOINT [ "/home/admin/startup.sh" ]
