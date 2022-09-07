FROM python:3.9-bullseye
RUN mkdir -p /opt/accupara/logs && \
    mkdir -p /opt/accupara/deploy

EXPOSE 5000
ENTRYPOINT ["/opt/accupara/deploy/bin/deploy", "server"]
