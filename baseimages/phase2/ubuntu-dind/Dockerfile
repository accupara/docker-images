# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Get the version numbers from:
# https://docs.docker.com/engine/release-notes
# https://docs.docker.com/compose/release-notes/
# https://docs.docker.com/build/release-notes/
# https://github.com/helm/helm/releases
# https://go.dev/doc/devel/release
# https://github.com/kubernetes-sigs/kind/releases
# https://github.com/hashicorp/packer/releases
ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=27.4.0 \
    DOCKER_COMPOSE_VERSION=v2.31.0 \
    BUILDX_VERSION=v0.19.1 \
    HELM_VER=3.16.3 \
    GOLANG_VER=1.23.0 \
    KIND_VER=0.25.0 \
    PACKER_VER=1.11.2 \
    DEBUG=false

COPY modprobe startup.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/conf.d/
COPY logger.sh /opt/bash-utils/logger.sh

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        ca-certificates \
        clang \
        cpio \
        cron \
        curl \
        flex \
        gawk \
        gcc-arm-linux-gnueabi \
        iproute2 \
        iptables \
        libelf-dev \
        libncurses5-dev \
        libssl-dev \
        openssh-client \
        openssl \
        perl \
        python3 \
        python3-pip \
        qemu-kvm \
        supervisor \
        wget \
# Docker and buildx installation
# Calculate alternative arch names
 && arch="$(uname -m)"; \
	case "$arch" in \
        # amd64
		x86_64)  dockerArch='x86_64'  ; altArch='amd64' ; buildx_arch='linux-amd64' ;; \
        # arm32v6
		armhf)   dockerArch='armel'   ; altArch='armel' ; buildx_arch='linux-arm-v6' ;; \
        # arm32v7
		armv7)   dockerArch='armhf'   ; altArch='armhf' ; buildx_arch='linux-arm-v7' ;; \
        # arm64v8
		aarch64) dockerArch='aarch64' ; altArch='arm64' ; buildx_arch='linux-arm64' ;; \
		*) echo >&2 "error: unsupported architecture ($arch)"; exit 1 ;;\
	esac \
 && mkdir -p /tmp/deps && cd /tmp/deps \
# Install Docker
 && if ! sudo -E wget -q -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for '${dockerArch}'"; \
		exit 1; \
	fi; \
	\
	sudo -E tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	sudo -E rm docker.tgz; \
	if ! sudo -E wget -q -O docker-buildx "https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.${buildx_arch}"; then \
		echo >&2 "error: failed to download 'buildx-${BUILDX_VERSION}.${buildx_arch}'"; \
		exit 1; \
	fi; \
	sudo -E mkdir -p /usr/local/lib/docker/cli-plugins; \
	sudo -E chmod +x docker-buildx; \
	sudo -E mv docker-buildx /usr/local/lib/docker/cli-plugins/docker-buildx; \
	\
	sudo -E dockerd --version; \
	sudo -E docker --version; \
	sudo -E docker buildx version \
# Add user to docker group
 && sudo groupadd docker \
 && sudo usermod -aG docker admin \
# Prep for all deps
 && mkdir -p /tmp/deps && cd /tmp/deps \
 && sudo -E chmod +x /usr/local/bin/startup.sh /usr/local/bin/modprobe \
# Docker compose installation
 && wget -q "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(arch)" -O docker-compose \
 && sudo install -o root -g root -m 0755 docker-compose /usr/local/bin/docker-compose \
 && docker-compose version \
# Create a symlink to the docker binary in /usr/local/lib/docker/cli-plugins
# for users which uses 'docker compose' instead of 'docker-compose'
 && sudo -E ln -s /usr/local/bin/docker-compose /usr/local/lib/docker/cli-plugins/docker-compose \
# AWS CLI
 && wget -q "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -O "awscliv2.zip"\
 && unzip awscliv2.zip \
 && sudo ./aws/install \
# kubectl and minikube
 && wget -q https://storage.googleapis.com/minikube/releases/latest/minikube-linux-${altArch} \
 && sudo install minikube-linux-${altArch} /usr/local/bin/minikube \
 && wget -q "https://dl.k8s.io/release/$(wget -q -O - https://dl.k8s.io/release/stable.txt)/bin/linux/${altArch}/kubectl" \
 && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
# helm
 && wget -q https://get.helm.sh/helm-v${HELM_VER}-linux-${altArch}.tar.gz \
 && tar -zxf helm-v${HELM_VER}-linux-${altArch}.tar.gz \
 && sudo mv linux-${altArch}/helm /usr/local/bin/helm \
# Install helm secrets
 && helm plugin install https://github.com/jkroepke/helm-secrets \
# Install monit
 && sudo eatmydata apt-get update -y \
 && sudo eatmydata apt-get install -y monit \
 && echo "set daemon 5i\n \
set httpd port 2812 and\n \
  allow localhost\n \
  allow admin:monit \
" >sudo tee /etc/monit/conf.d/custom.settings \
# golang and kind
 && wget -q https://go.dev/dl/go1.20.1.linux-${altArch}.tar.gz \
 && sudo tar -C /usr/local -xzf go1.20.1.linux-${altArch}.tar.gz \
 && sudo ln -s /usr/local/go/bin/go /usr/local/bin/go \
 && export GOPATH=/opt/go \
 && sudo mkdir -p /opt/go \
 && sudo go install sigs.k8s.io/kind@v${KIND_VER} \
# Packer
 && cd /tmp/deps \
 && wget -q https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_${altArch}.zip \
 && unzip packer_${PACKER_VER}_linux_${altArch}.zip \
 && sudo mv packer /usr/bin/ \
# Packer qemu plugin
 && packer plugins install github.com/hashicorp/qemu \
 && sudo packer plugins install github.com/hashicorp/qemu \
# Cleanup
 && cd /tmp/ \
 && sudo find /tmp/deps -delete \
 && sudo eatmydata apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["startup.sh"]

USER root
ENV HOME=/root \
    USER=root \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /root
CMD ["/bin/bash"]
VOLUME /var/lib/docker
