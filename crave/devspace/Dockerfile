# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM eclipse-temurin:8-jdk-centos7 AS jdk
FROM accupara/xpra:24.04

# See https://hub.docker.com/_/eclipse-temurin
COPY --from=jdk /opt/java/openjdk /opt/java/openjdk

# CI=true is to tell jfrog to be noninteractive
ENV YQ_VER=4.40.3 \
    CRANE_VER=0.19.0 \
    CI=true \
    JAVA_HOME=/opt/java/openjdk \
    PATH=/opt/java/openjdk/bin:/opt/java/maven/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
# Update the underlying base image
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get -y update \
# Install LXDE + a bunch of x utilities for VNC and a browser, a decent ide, some monitoring tools
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y \
      arc-theme \
      bmon \
      cscope \
      exuberant-ctags \
      fish \
      gnome-themes-ubuntu \
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
      shellinabox \
      software-properties-common \
      supervisor \
      task-lxde-desktop \
      telnet \
      tmate \
      unminimize \
      vim-gtk3 \
      x11vnc \
      xvfb \
      yarnpkg \
# Fix a problem in xfwm4
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata add-apt-repository ppa:xubuntu-dev/staging \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get update \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get upgrade -y \
# Get rid of the firefox snap and install it from PPA so that it is a regular debian package
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get purge -y firefox \
 && sudo eatmydata add-apt-repository ppa:mozillateam/ppa \
 && echo 'Package: *' | sudo tee /etc/apt/preferences.d/mozilla-firefox \
 && echo 'Pin: release o=LP-PPA-mozillateam' | sudo tee -a /etc/apt/preferences.d/mozilla-firefox \
 && echo 'Pin-Priority: 1001' | sudo tee -a /etc/apt/preferences.d/mozilla-firefox \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get update \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --allow-downgrades firefox \
# Install the GRPC tool for crave clone
 && mkdir -p /tmp/grpcurl_download \
 && LOCATION=$(curl -s https://api.github.com/repos/fullstorydev/grpcurl/releases/latest \
       | grep "tag_name" \
       | awk '{print "https://github.com/fullstorydev/grpcurl/releases/download/v" substr($2, 3, length($2)-4) "/grpcurl_" substr($2, 3, length($2)-4) "_linux_x86_64.tar.gz"}') \
 && curl -L $LOCATION | tar xvz -C /tmp/grpcurl_download \
 && sudo cp /tmp/grpcurl_download/grpcurl /usr/bin \
 && rm -rf /tmp/grpcurl_download \
# Install IntelliJ: Disabled until we find a use for it inside devspace
# && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y \
#    libfontconfig1 \
#    libgtk-3-0 \
#    libxtst6 \
#    libxrender1 \
#    libxi6 \
#    python3-pip \
# && sudo python3 -m pip install --break-system-packages projector-installer \
# && projector --accept-license autoinstall \
#    --config-name "Idea" \
#    --ide-name 'IntelliJ IDEA Community Edition 2024.3.1' \
#    --hostname localhost \
#    --port 5898 \
#    --use-separate-config \
# && projector --accept-license autoinstall \
#    --config-name "PyCharm" \
#    --ide-name 'PyCharm Community Edition 2024.3.1' \
#    --hostname localhost \
#    --port 5897 \
#    --use-separate-config \
# Get the latest version of repo
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mkdir -p /opt/aosp \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
 && sudo chown -R admin:admin /opt/aosp \
# Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
# Make sure that the default version of python is 3
 && if [ $(python --version | grep -c 'Python 3') -eq "0" ] ; then exit 1 ; fi \
# LXDE tweaks
 && mkdir -p /home/admin/.config/pcmanfm/LXDE/ \
# Unminimize so that man pages are present: not available for 24.04??
 && yes | sudo unminimize \
# Make git statuses faster
 && git config --global feature.manyFiles true \
# Add the crane tool
 && wget -q -O /tmp/go-crane.tar.gz https://github.com/google/go-containerregistry/releases/download/v${CRANE_VER}/go-containerregistry_Linux_x86_64.tar.gz \
 && mkdir -p /tmp/crane \
 && tar -C /tmp/crane -xvf /tmp/go-crane.tar.gz \
 && sudo mv /tmp/crane/crane /tmp/crane/gcrane /tmp/crane/krane /usr/bin/ \
 && rm -rf /tmp/crane /tmp/go-crane.tar.gz \
# Add the GCloud tools
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get update \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y google-cloud-cli \
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
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get update \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y jfrog-cli-v2 \
# Install the deps for autocompletions for the crave client binary inside devspace sessions
 && sudo eatmydata add-apt-repository -y universe \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get -y update \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y python3-pip \
 && sudo python -m pip -v install --break-system-packages argcomplete \
 && mkdir -p /home/admin/.bash_completion.d \
 && register-python-argcomplete crave > /tmp/crave_bash_completion \
 && cp /tmp/crave_bash_completion /home/admin/.bash_completion.d/crave \
 && sudo chown -R admin:admin /home/admin/.bash_completion.d \
# Install Rclone
 && curl https://rclone.org/install.sh | sudo bash -s beta \
# Save the telegram upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/telegram \
 && sudo chown -R admin:admin /opt/crave \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/tgup.sh -O /opt/crave/telegram/upload.sh \
 && chmod +x /opt/crave/telegram/upload.sh \
# Save the upload.sh script into the appropriate location
 && sudo mkdir -p /opt/crave/github-actions \
 && sudo chown -R admin:admin /opt/crave \
 && wget https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/upload.sh -O /opt/crave/github-actions/upload.sh \
 && chmod +x /opt/crave/github-actions/upload.sh \
# Save the backblaze_keygen.sh script into the appropriate location
 && sudo chown -R admin:admin /opt/crave \
 && wget -q https://raw.githubusercontent.com/accupara/docker-images/master/aosp/common/backblaze_keygen.sh -O /opt/crave/backblaze_keygen.sh \
 && chmod +x /opt/crave/backblaze_keygen.sh \
# Install the VS Code Server
 && curl -fsSL https://code-server.dev/install.sh | sh \
# Then install some extensions by default
 && export PLUGIN_LIST="\
      bierner.markdown-mermaid \
      crave-io.crave-devspaces \
      eamodio.gitlens \
      ms-vscode.cpptools \
      ms-python.python \
      ms-vscode.makefile-tools \
      redhat.java \
      vscodevim.vim \
      yzhang.markdown-all-in-one \
      yzane.markdown-pdf \
      " \
 && for i in $PLUGIN_LIST ; do \
      code-server --install-extension $i ; \
    done \
# What a load of croc
 && curl https://getcroc.schollz.com | bash \
# Some python modules worth including in the base devspace image
 && sudo python -m pip -v install --break-system-packages pudb \
# The usual cleanup
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

# Copy everything in one shot and then move each file to its appropriate location
COPY vnc.conf tmux.conf vscode.conf intellij.conf shellinabox.conf sshd_config init.sh supervisord.conf repo startup.sh /tmp/
RUN set -x \
# Put the supervisor conf where it needs to be
 && sudo mkdir -p /etc/crave/supervisor \
 && cd /tmp \
 && sudo mv supervisord.conf /etc/supervisor/ \
 && sudo mv vnc.conf shellinabox.conf vscode.conf intellij.conf /etc/supervisor/conf.d/ \
# Put the tmux conf where it should be
 && sudo mv /tmp/tmux.conf /home/admin/.tmux.conf \
# Put the sshd conf where it should be
 && sudo mv /tmp/sshd_config /etc/ssh/sshd_config \
# Copy the init script to its intended location
 && sudo mv /tmp/init.sh /etc/crave/ \
# Move repo to repo.real and put the shim in its place
 && sudo mv /usr/bin/repo /usr/bin/repo.real \
 && sudo mv /tmp/repo /usr/bin/repo.shim \
 && sudo ln -sf /usr/bin/repo.shim /usr/bin/repo \
# Put the startup script somewhere useful
 && sudo mv /tmp/startup.sh /etc/crave/supervisor

ENTRYPOINT [ "/etc/crave/supervisor/startup.sh" ]
