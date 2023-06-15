FROM golang:1.11.2-stretch
RUN mkdir -p /opt/accupara/logs && mkdir /opt/accupara/bin && \
    GRPC_HEALTH_PROBE_VERSION=v0.2.0 && \
    wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe
RUN 'curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -'
RUN sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    sudo apt-get update && \
    sudo apt-get -y dist-upgrade && \
    sudo apt-get install -y \
	vim-gtk3 \
	packer
EXPOSE 31001
ENTRYPOINT ["/opt/accupara/bin/drpacker"]
