# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/rockylinux:9

RUN sudo dnf update -y && \
    sudo dnf groupinstall -y "Development Tools" && \
    sudo dnf install -y \
     bc \
     clang-devel \
     createrepo \
     dos2unix \
     e2fsprogs-devel \
     krb5-devel \
     libcurl-devel \
     libicu-devel \
     libselinux-devel \
     libuuid-devel \
     libxml2-devel \
     libxslt-devel \
     llvm-devel \
     lz4-devel \
     openldap-devel \
     openssl-devel \
     pam-devel \
     perl \
     perl-ExtUtils-Embed \
     python3-devel \
     readline-devel \
     rpmdevtools \
     selinux-policy \
     systemd-devel \
     systemtap-sdt-devel \
     tcl-devel \
     which && \
    sudo dnf install -y epel-release && \
    sudo dnf --enablerepo=devel install -y perl-IPC-Run hdf5 hdf5-devel
