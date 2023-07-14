# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu-dind:latest

# Get the version numbers from:
# https://github.com/helm/helm/releases
# https://go.dev/doc/devel/release
# https://github.com/kubernetes-sigs/kind/releases
ENV HELM_VER=3.12.1 \
    GOLANG_VER=1.20.6 \
    KIND_VER=0.20.0

RUN set -x \
 && mkdir -p /tmp/deps && cd /tmp/deps \
# Calculate alternative arch names
 && arch="$(uname -m)" \
 && case "$arch" in \
        # amd64
        x86_64)  altArch='amd64' ;; \
        # arm32v6
        armhf)   altArch='armel' ;; \
        # arm32v7
        armv7)   altArch='armhf' ;; \
        # arm64v8
        aarch64) altArch='arm64' ;; \
        *) echo >&2 "error: unsupported architecture ($arch)"; exit 1 ;;\
    esac \
# kubectl and minikube
 && curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-${altArch} \
 && sudo install minikube-linux-${altArch} /usr/local/bin/minikube \
 && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${altArch}/kubectl" \
 && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
# helm
 && wget -q https://get.helm.sh/helm-v${HELM_VER}-linux-${altArch}.tar.gz \
 && tar -zxf helm-v${HELM_VER}-linux-${altArch}.tar.gz \
 && sudo mv linux-${altArch}/helm /usr/local/bin/helm \
# Install helm secrets
 && helm plugin install https://github.com/jkroepke/helm-secrets \
# Install monit
 && sudo apt-get update -y \
 && sudo apt install -y monit \
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
# Cleanup
 && cd /tmp/ \
 && sudo find /tmp/deps -delete

USER root
ENV HOME=/root \
    USER=root \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /root
CMD /bin/bash
