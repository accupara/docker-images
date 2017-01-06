# Copyright (c) 2016 Accupara Inc. All rights reserved

SUBDIRS=ubuntu centos django-nginx linuxkernel rsync qt qemu lfs ffmpeg duperemove mobile

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs
