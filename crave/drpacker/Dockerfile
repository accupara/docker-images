# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/golang:1.21-bullseye

RUN set -x \
 && sudo mkdir -p /opt/accupara/logs \
 && sudo mkdir /opt/accupara/bin \
 && GRPC_HEALTH_PROBE_VERSION=v0.2.0 \
 && wget -q -O /tmp/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 \
 && chmod +x /tmp/grpc_health_probe \
 && sudo mv /tmp/grpc_health_probe /usr/bin/ \
# Install packer
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
 && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
 && sudo apt-get update \
 && sudo apt-get install -y \
	vim-nox \
	packer

EXPOSE 31001
ENTRYPOINT ["/opt/accupara/bin/drpacker"]
