# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# RUN sudo useradd -m chromium \
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    asciidoc \
	bsdmainutils \
    gcc-multilib \
	iproute2 \
	iptables \
	kmod \
	libaio-dev \
	libbsd-dev \
	libcap-dev \
    libdrm-dev \
	libgnutls28-dev \
	libgnutls30 \
	libprotobuf-c-dev \
	libprotobuf-dev \
	libnet1-dev \
	libnftables-dev \
	libnl-3-dev \
	libnl-route-3-dev \
	libselinux-dev \
	pkg-config \
	protobuf-c-compiler \
	protobuf-compiler \
	python3-minimal \
	python3-pip \
	python3-protobuf \
	python3-yaml \
# Cleanup
 && sudo eatmydata apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*
