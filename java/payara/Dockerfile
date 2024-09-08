# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

FROM payara/server-full:5.2022.5 AS payara

FROM accupara/openjdk:8

COPY --from=payara /opt/payara/ /opt/payara/

# From https://github.com/payara/Payara/blob/main/appserver/extras/docker-images/server-full/src/main/docker/Dockerfile
# and https://hub.docker.com/r/payara/server-full/dockerfile/
ENV HOME_DIR=/opt/payara
ENV PAYARA_DIR=${HOME_DIR}/appserver \
    SCRIPT_DIR=${HOME_DIR}/scripts \
    CONFIG_DIR=${HOME_DIR}/config \
    DEPLOY_DIR=${HOME_DIR}/deployments \
    PASSWORD_FILE=${HOME_DIR}/passwordFile \
    ADMIN_USER=admin \
    ADMIN_PASSWORD=admin \
    JVM_ARGS="" \
    MEM_MAX_RAM_PERCENTAGE="70.0" \
    MEM_XSS="512k" \
    DOMAIN_NAME=production \
    PAYARA_ARGS="" \
    DEPLOY_PROPS=""
ENV PATH="${PATH}:${PAYARA_DIR}/bin" \
    PREBOOT_COMMANDS=${CONFIG_DIR}/pre-boot-commands.asadmin \
    PREBOOT_COMMANDS_FINAL=${CONFIG_DIR}/pre-boot-commands-final.asadmin \
    POSTBOOT_COMMANDS=${CONFIG_DIR}/post-boot-commands.asadmin \
    POSTBOOT_COMMANDS_FINAL=${CONFIG_DIR}/post-boot-commands-final.asadmin

# Honestly, there's not much else to be done than to copy the payara binaries from one location: /opt/payara
# So there's no more commands here.
