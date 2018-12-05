FROM golang:1.11.2-stretch
RUN mkdir -p /opt/accupara/logs && mkdir /opt/accupara/bin && \
    GRPC_HEALTH_PROBE_VERSION=v0.2.0 && \
    wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe
EXPOSE 25001
ENTRYPOINT ["/opt/accupara/bin/jobserver"]
