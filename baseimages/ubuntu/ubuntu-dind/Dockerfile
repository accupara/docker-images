# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

# Get the version numbers from:
# https://docs.docker.com/engine/release-notes
# https://docs.docker.com/compose/release-notes/
# https://docs.docker.com/build/release-notes/
ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=24.0.4 \
    DOCKER_COMPOSE_VERSION=v2.20.0 \
    BUILDX_VERSION=v0.11.1 \
    DEBUG=false

COPY modprobe startup.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/conf.d/
COPY logger.sh /opt/bash-utils/logger.sh

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
	sudo -E docker buildx version \
# Add user to docker group
 && sudo groupadd docker \
 && sudo usermod -aG docker admin \
# Prep for all deps
 && mkdir -p /tmp/deps && cd /tmp/deps \
 && sudo -E chmod +x /usr/local/bin/startup.sh /usr/local/bin/modprobe \
# Docker compose installation
 && sudo -E curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(arch)" -o /usr/local/bin/docker-compose \
 && sudo -E chmod +x /usr/local/bin/docker-compose \
 && docker-compose version \
# Create a symlink to the docker binary in /usr/local/lib/docker/cli-plugins
# for users which uses 'docker compose' instead of 'docker-compose'
 && sudo -E ln -s /usr/local/bin/docker-compose /usr/local/lib/docker/cli-plugins/docker-compose \
# AWS CLI
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-$(arch).zip" -o "awscliv2.zip"\
 && unzip awscliv2.zip \
 && sudo ./aws/install \
# Cleanup
 && cd /tmp/ \
 && sudo find /tmp/deps -delete \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["startup.sh"]

USER root
ENV HOME=/root \
    USER=root \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /root
CMD /bin/bash
VOLUME /var/lib/docker
