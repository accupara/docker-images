# Copyright (c) 2016-2017 Accupara Inc. All rights reserved

SUBDIRS=ubuntu centos business-cards django-nginx linuxkernel rsync qt qemu duperemove mozilla mobile
# incomplete or untested: ffmpeg vlc yocto dpdk gcc glibc

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs
