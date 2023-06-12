# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        ca-certificates \
        clang-6.0 \
        cpio \
        curl \
        flex \
        gawk \
        gcc-arm-linux-gnueabi \
        iptables \
        libelf-dev \
        libncurses5-dev \
        libssl-dev \
        openssh-client \
        openssl \
        perl \
        qemu-kvm \
        supervisor \
        wget \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

ENV DOCKER_CHANNEL=stable \
	DOCKER_VERSION=23.0.1 \
	DOCKER_COMPOSE_VERSION=v2.16.0 \
	BUILDX_VERSION=v0.10.3 \
	DEBUG=false

# Docker and buildx installation
RUN set -eux; \
	\
	arch="$(uname -m)"; \
	case "$arch" in \
        # amd64
		x86_64) dockerArch='x86_64' ; buildx_arch='linux-amd64' ;; \
        # arm32v6
		armhf) dockerArch='armel' ; buildx_arch='linux-arm-v6' ;; \
        # arm32v7
		armv7) dockerArch='armhf' ; buildx_arch='linux-arm-v7' ;; \
        # arm64v8
		aarch64) dockerArch='aarch64' ; buildx_arch='linux-arm64' ;; \
		*) echo >&2 "error: unsupported architecture ($arch)"; exit 1 ;;\
	esac; \
	\
	if ! sudo -E wget -q -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz"; then \
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
	sudo -E docker buildx version

COPY modprobe startup.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/conf.d/
COPY logger.sh /opt/bash-utils/logger.sh

RUN sudo -E chmod +x /usr/local/bin/startup.sh /usr/local/bin/modprobe
VOLUME /var/lib/docker

# Docker compose installation
RUN sudo -E curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
 && sudo -E chmod +x /usr/local/bin/docker-compose && docker-compose version
	
# Create a symlink to the docker binary in /usr/local/lib/docker/cli-plugins
# for users which uses 'docker compose' instead of 'docker-compose'
RUN sudo -E ln -s /usr/local/bin/docker-compose /usr/local/lib/docker/cli-plugins/docker-compose


# kubectl and minikube
RUN set -x \
 && curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
 && sudo install minikube-linux-amd64 /usr/local/bin/minikube \
 && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# helm
RUN set -x \
 && wget https://get.helm.sh/helm-v3.9.2-linux-amd64.tar.gz \
 && tar -zxvf helm-v3.9.2-linux-amd64.tar.gz \
 && sudo mv linux-amd64/helm /usr/local/bin/helm

ENTRYPOINT ["startup.sh"]

USER root
ENV HOME=/root \
    USER=root \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /root
CMD /bin/bash
