# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY CCS10.1.0.00010_linux-x64.tar.gz /tmp/

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo -E apt-get install -y \
       libc6-i386 \
       libgconf-2-4 \
       libncurses5 \
       libusb-0.1-4 \
       wget \
 && export CCS_TAR=CCS10.1.0.00010_linux-x64.tar.gz \
 && cd /tmp \
 && tar -xf $CCS_TAR \
 && sudo ./ccs_setup_10.1.0.00010.run \
    --mode unattended \
    --enable-components PF_MSP430,PF_MSP432,PF_CC2X,PF_CC3X,PF_CC2538,PF_C28,PF_TM4C,PF_PGA,PF_HERCULES,PF_SITARA,PF_OMAPL,PF_DAVINCI,PF_OMAP,PF_TDA_DRA,PF_C55,PF_C6000SC,PF_C66AK_KEYSTONE,PF_MMWAVE,PF_C64MC,PF_DIGITAL_POWER \
    --install-BlackHawk true \
    --install-Segger true \
 && cd /tmp/ \
 && rm $CCS_TAR \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
