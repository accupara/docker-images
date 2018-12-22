FROM python:3.7.1-stretch
RUN mkdir -p /opt/accupara/logs && \
    mkdir -p /opt/accupara/deploy

EXPOSE 5000
ENTRYPOINT ["/opt/accupara/deploy/bin/deploy", "server"]
