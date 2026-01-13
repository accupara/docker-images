# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

# Downloaded from https://www.ti.com/tool/download/CCSTUDIO
# wget -q https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/12.4.0/CCS12.4.0.00007_linux-x64.tar.gz
#ADD CCS12.4.0.00007_linux-x64.tar.gz /tmp/

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update \
 && sudo -E eatmydata apt-get install -y \
# Deps info from: https://software-dl.ti.com/ccs/esd/documents/ccsv10_linux_host_support.html
       libc6-i386 \
       libgconf-2-4 \
       libncurses5 \
       udev \
       libusb-0.1-4 \
       wget \
# Installation errors avoided by following: https://github.com/sirde/ccs-v7-ci/blob/master/Dockerfile
 && sudo mkdir -p /etc/udev/rules.d \
# Install CCS
 && export CCS_VER=12.4.0.00007 \
 && mkdir -p /tmp/ccs && cd /tmp/ccs \
 && wget -q https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/12.4.0/CCS${CCS_VER}_linux-x64.tar.gz \
 && tar -xf CCS${CCS_VER}_linux-x64.tar.gz \
 && cd CCS${CCS_VER}_linux-x64 \
 && sudo ./ccs_setup_${CCS_VER}.run \
    --mode unattended \
    --enable-components PF_MSP430,PF_MSP432,PF_CC2X,PF_CC3X,PF_CC2538,PF_C28,PF_TM4C,PF_PGA,PF_HERCULES,PF_SITARA,PF_OMAPL,PF_DAVINCI,PF_OMAP,PF_TDA_DRA,PF_C55,PF_C6000SC,PF_C66AK_KEYSTONE,PF_MMWAVE,PF_C64MC,PF_DIGITAL_POWER \
    --install-BlackHawk true \
    --install-Segger true \
# Minimize image
 && cd /tmp/ \
 && sudo rm -rf /tmp/ccs \
 && sudo eatmydata apt-get autoremove -y \
 && sudo eatmydata apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
