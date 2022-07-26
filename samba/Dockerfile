# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo -E apt-get install -y \
       acl \
       attr \
       autoconf \
       bind9utils \
       bison \
       build-essential \
       debhelper \
       dnsutils \
       docbook-xml \
       docbook-xsl \
       flex \
       gdb \
       libjansson-dev \
       krb5-user \
       libacl1-dev \
       libaio-dev \
       libarchive-dev \
       libattr1-dev \
       libblkid-dev \
       libbsd-dev \
       libcap-dev \
       libcups2-dev \
       libdbus-1-dev \
       libgnutls28-dev \
       libgpgme-dev \
       libjson-perl \
       libldap2-dev \
       libncurses5-dev \
       libpam0g-dev \
       libparse-yapp-perl \
       libpopt-dev \
       libreadline-dev \
       nettle-dev \
       perl \
       perl-modules \
       pkg-config \
       python-all-dev \
       python-crypto \
       python-dbg \
       python-dev \
       python-dnspython \
       python3-dnspython \
       python-gpg \
       python3-gpg \
       python-markdown \
       python3-markdown \
       python3-dev \
       xsltproc \
       zlib1g-dev \
       liblmdb-dev \
       lmdb-utils \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
